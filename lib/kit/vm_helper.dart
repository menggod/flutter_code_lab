library service_tester;

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';
import 'package:vm_service/utils.dart';

import 'version.dart';

int _key = 0;

/// 顶级函数，必须常规方法，生成 key 用
String generateNewKey() {
  return "${++_key}";
}

Map<String, dynamic> _objCache = Map();

/// 顶级函数，根据 key 返回指定对象
dynamic keyToObj(String key) {
  return _objCache[key];
}

class VmHelper {
  VmHelper._privateConstructor();

  static final VmHelper _instance = VmHelper._privateConstructor();

  static VmHelper get instance => _instance;

  VmService _serviceClient;
  Version _protocolVersion;
  Version _dartIoVersion;

  VM vm;

  String isolateId = "";

  // flutter版本
  String _flutterVersion = '';

  // 各Isolate内存使用情况
  Map<IsolateRef, MemoryUsage> memoryInfo = new Map();
  bool connected;
  AllocationProfile allocationProfile;
  PackageInfo packageInfo;

  Map<String, List<String>> get registeredMethodsForService => _registeredMethodsForService;
  final Map<String, List<String>> _registeredMethodsForService = {};

  startConnect() async {
    ServiceProtocolInfo info = await Service.getInfo();
    if (info == null || info.serverUri == null) {
      debugPrint("service  protocol url is null,start vm service fail");
      return;
    }
    Uri uri = convertToWebSocketUrl(serviceProtocolUrl: info.serverUri);
    _serviceClient = await vmServiceConnectUri(uri.toString(), log: StdoutLog());
    debugPrint('socket connected in service $info');
    connected = true;

    vm = await _serviceClient.getVM();
    List<IsolateRef> isolates = vm.isolates;

    isolates.forEach((element) async {
      isolateId = element.id;
      MemoryUsage memoryUsage = await _serviceClient.getMemoryUsage(element.id);
      memoryInfo[element] = memoryUsage;
    });
    loadExtensionService();
    PackageInfo.fromPlatform().then((value) => packageInfo = value);
  }

  // 获取flutter版本，目前比较鸡肋，需要借助devtools向vmservice注册的服务来获取,flutter 未 attach的情况下无法使用。
  void loadExtensionService() async {
    final serviceStreamName = await this.serviceStreamName;
    _serviceClient.onEvent(serviceStreamName).listen(handleServiceEvent);
    final streamIds = [
      EventStreams.kDebug,
      EventStreams.kExtension,
      EventStreams.kGC,
      EventStreams.kIsolate,
      EventStreams.kLogging,
      EventStreams.kStderr,
      EventStreams.kStdout,
      EventStreams.kTimeline,
      EventStreams.kVM,
      serviceStreamName,
    ];

    await Future.wait(streamIds.map((String id) async {
      try {
        await _serviceClient.streamListen(id);
      } catch (e) {
        debugPrint(e);
      }
    }));
    resolveFlutterVersion();
  }

  String get flutterVersion {
    if (_flutterVersion != '') {
      return _flutterVersion;
    } else {
      return 'Flutter Attach后可获取版本号';
    }
  }

  Future<String> get serviceStreamName async =>
      (await isProtocolVersionSupported(supportedVersion: SemanticVersion(major: 3, minor: 22)))
          ? 'Service'
          : '_Service';

  Future<bool> isProtocolVersionSupported({
    @required SemanticVersion supportedVersion,
  }) async {
    _protocolVersion ??= await _serviceClient.getVersion();
    return isProtocolVersionSupportedNow(supportedVersion: supportedVersion);
  }

  bool isProtocolVersionSupportedNow({
    @required SemanticVersion supportedVersion,
  }) {
    return _versionSupported(
      version: _protocolVersion,
      supportedVersion: supportedVersion,
    );
  }

  bool _versionSupported({
    @required Version version,
    @required SemanticVersion supportedVersion,
  }) {
    return SemanticVersion(
      major: version.major,
      minor: version.minor,
    ).isSupported(supportedVersion: supportedVersion);
  }

  Future<bool> isDartIoVersionSupported({
    @required SemanticVersion supportedVersion,
    @required String isolateId,
  }) async {
    _dartIoVersion ??= await getDartIOVersion(isolateId);
    return _versionSupported(
      version: _dartIoVersion,
      supportedVersion: supportedVersion,
    );
  }

  Future<Version> getDartIOVersion(String isolateId) => _serviceClient.getDartIOVersion(isolateId);

  void handleServiceEvent(Event e) {
    if (e.kind == EventKind.kServiceRegistered) {
      final serviceName = e.service;
      _registeredMethodsForService.putIfAbsent(serviceName, () => []).add(e.method);
      if (_flutterVersion == '' && serviceName == 'flutterVersion') {
        resolveFlutterVersion();
      }
    }

    if (e.kind == EventKind.kServiceUnregistered) {
      final serviceName = e.service;
      _registeredMethodsForService.remove(serviceName);
    }
  }

  void resolveFlutterVersion() {
    callMethod('flutterVersion')
        ?.then((value) => _flutterVersion = FlutterVersion.parse(value.json).version);
  }

  Future<Response> callMethod(String method) {
    if (registeredMethodsForService.containsKey(method)) {
      return (_serviceClient.callMethod(registeredMethodsForService[method].last,
          isolateId: vm.isolates.first.id));
    }
    return null;
  }

  updateMemoryUsage() {
    if (_serviceClient != null && connected) {
      List<IsolateRef> isolates = vm.isolates;
      isolates.forEach((element) {
        _serviceClient.getMemoryUsage(element.id).then((value) => memoryInfo[element] = value);
      });
    }
  }

  dumpAllocationProfile() async {
    if (_serviceClient != null && connected) {
      _serviceClient
          .getAllocationProfile(vm.isolates.first.id)
          .then((value) => allocationProfile = value);
    }
  }

  disConnect() async {
    if (_serviceClient != null) {
      debugPrint('waiting for client to shut down...');
      _serviceClient.dispose();

      await _serviceClient.onDone;
      connected = false;
      _serviceClient = null;
      debugPrint('service client shut down');
    }
  }

  gc() async {
    // await serviceClient.getAllocationProfile(isolateId, gc: true);
    // debugPrint('menggod vm_helper gc: $isolateId');
  }

  getScripts() async {
    ScriptList scripts = await _serviceClient.getScripts(isolateId);
    var list = scripts.scripts;
    var list2 = list.where((element) => element.uri.contains("life_cycle.dart")).toList();
    ScriptRef bean = list2.first;

    debugPrint('menggod vm_helper ScriptRef:${list2.length} ${bean.toString()} ');
    Script script = await _serviceClient.getObject(isolateId, bean.id);
    debugPrint('menggod vm_helper getScripts: ${script.toString()} ');

    return scripts;
  }

  getLibrary() async {
    var isolate = await _serviceClient.getIsolate(isolateId);
    var libraries = isolate.libraries;
    var refList = libraries.where((element) => element.uri.contains("life_cycle.dart")).toList();
    var libRef = refList.first;

    Library libBean = await _serviceClient.getObject(isolateId, libRef.id);
    debugPrint(
        'menggod vm_helper getLibrary-->${libRef.toString()}  lib obj-->${libBean.toString()}');
    debugPrint('-------------------------------------------');

    var classBean = await _serviceClient.getObject(isolateId, libBean.classes[1].id);
    debugPrint('menggod vm_helper getLibrary: ${classBean.toString()}');
    debugPrint('-------------------------------------------');

    var toolsId = await getToolsId();
    var id = await obj2Id(_serviceClient, isolateId, toolsId, libBean);
    debugPrint('menggod vm_helper objId: $id');
    debugPrint('-------------------------------------------');

    var obj = await _serviceClient.getObject(isolateId, id);

    debugPrint('-------------------------------------------');

    var path = await _serviceClient.getRetainingPath(isolateId, id, 1000);
    debugPrint('menggod vm_helper getLibrary: ${path.toString()}');
  }

  getObject(dynamic obj) async {
    var toolsId = await getToolsId();
    var id = await obj2Id(_serviceClient, isolateId, toolsId, obj);
    debugPrint('menggod vm_helper getObject: $id');
  }

  Future<String> getToolsId() async {
    var isolate = await _serviceClient.getIsolate(isolateId);
    var libraries = isolate.libraries;
    var refList = libraries.where((element) => element.uri.contains("vm_helper.dart")).toList();
    var libRef = refList.first;
    Library libBean = await _serviceClient.getObject(isolateId, libRef.id);
    return libBean.id;
  }

  getScriptsFuture() {
    return _serviceClient.getScripts(isolateId);
  }

  getRetainingPath(String targetId) {
    _serviceClient.getRetainingPath(isolateId, targetId, 1000);
  }

  invoke(String targetId) {
    // _serviceClient.invoke(isolateId, targetId, selector, argumentIds)
  }

  getIsolateBean() {
    return _serviceClient.getIsolate(isolateId);
  }

  /// 对象转 id
  Future<String> obj2Id(VmService service, String isolateId, String libraryId, dynamic obj) async {
    // 找到当前 Library。这里可以遍历 isolate 的 libraries 字段
    // 根据 uri 筛选出当前 Library 即可，具体不展开了

    // 用 vm service 执行 generateNewKey 函数
    InstanceRef keyRef = await service.invoke(isolateId, libraryId, "generateNewKey", []);
    // 获取 keyRef 的 String 值
    // 这是唯一一个能把 ObjRef 类型转为数值的 api
    String key = keyRef.valueAsString;

    var object = await _serviceClient.getObject(isolateId, keyRef.id);
    debugPrint('menggod vm_helper[$key}] 11111: ${object.toString()}');

    _objCache[key] = obj;
    try {
      // 调用 keyToObj 顶级函数，传入 key，获取 obj
      InstanceRef valueRef = await service.invoke(isolateId, libraryId, "keyToObj",
          // 这里注意，vm_service 需要的是 id，不是值
          [keyRef.id]);
      // 这里的 id 就是 obj 对应的 id

      var object = await _serviceClient.getObject(isolateId, valueRef.id);
      debugPrint('menggod vm_helper[${valueRef.id}] 22222: ${object.toString()}');

      return valueRef.id;
    } finally {
      _objCache.remove(key);
    }
    return null;
  }
}

class StdoutLog extends Log {
  void warning(String message) => debugPrint(message);

  void severe(String message) => debugPrint(message);
}
