import 'dart:collection';

import 'package:flutter/material.dart';

class ApmKitManager {
  Map<String, ApmKit> kitMap = {};

  ApmKitManager._privateConstructor() {}

  static final ApmKitManager _instance = ApmKitManager._privateConstructor();

  static ApmKitManager get instance => _instance;

  void addKit(String tag, ApmKit kit) {
    kitMap[tag] = kit;
  }

  ApmKit? getKit<T extends ApmKit?>(String name) {
    if (kitMap.containsKey(name)) {
      return kitMap[name];
    }
    return null;
  }

  void startUp() {
    kitMap.forEach((key, kit) {
      kit.start();
    });
  }
}

abstract class IInfo {
  dynamic getValue();
}

abstract class IStorage {
  bool save(IInfo info);

  bool contains(IInfo info);

  List<IInfo> getAll();
}

abstract class IKit {
  String getKitName();

  String getIcon();

  void tabAction();
}

class CommonStorage implements IStorage {
  final int maxCount;
  Queue<IInfo> items = new Queue();

  CommonStorage({this.maxCount = 100});

  @override
  List<IInfo> getAll() {
    return items.toList();
  }

  @override
  bool save(IInfo info) {
    if (items.length >= maxCount) {
      items.removeFirst();
    }
    items.add(info);
    return true;
  }

  @override
  bool contains(IInfo info) {
    return items.contains(info);
  }
}

abstract class ApmKit implements IKit {
  late IStorage storage;

  void start();

  void stop();

  IStorage createStorage();

  Widget createDisplayPage();

  ApmKit() {
    storage = createStorage();
  }

  @override
  void tabAction() {}

  IStorage getStorage() {
    return storage;
  }
}

class ApmKitName {
  static const String KIT_FPS = '帧率';
  static const String KIT_MEMORY = '内存';
  static const String KIT_LOG = '日志查看';
  static const String KIT_ROUTE = '路由信息';
  static const String KIT_CHANNEL = '方法通道';
  static const String KIT_HTTP = '网络请求';
}
