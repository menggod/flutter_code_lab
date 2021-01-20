library service_tester;

import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';
import 'package:vm_service/utils.dart';

import 'version.dart';

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
      print("service  protocol url is null,start vm service fail");
      return;
    }
    Uri uri = convertToWebSocketUrl(serviceProtocolUrl: info.serverUri);
    _serviceClient = await vmServiceConnectUri(uri.toString(), log: StdoutLog());
    print('socket connected in service $info');
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
        print(e);
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
      print('waiting for client to shut down...');
      _serviceClient.dispose();

      await _serviceClient.onDone;
      connected = false;
      _serviceClient = null;
      print('service client shut down');
    }
  }

  gc() async {
    // await serviceClient.getAllocationProfile(isolateId, gc: true);
    // print('menggod vm_helper gc: $isolateId');
  }

  getScripts() async {
    var scripts = await _serviceClient.getScripts(isolateId);
    print('menggod vm_helper getScripts: ${scripts.toString()}');
  }

  getRetainingPath(String targetId) {
    _serviceClient.getRetainingPath(isolateId, targetId, 1000);
  }

  invoke(String targetId) {
    // _serviceClient.invoke(isolateId, targetId, selector, argumentIds)
  }
}

class StdoutLog extends Log {
  void warning(String message) => print(message);

  void severe(String message) => print(message);
}
