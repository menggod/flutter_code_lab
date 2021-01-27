import 'dart:async';

import 'package:dokit/dokit.dart';
import 'package:dokit/ui/dokit_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/my_app.dart';
import 'package:leak_memory_plugin/leak_memory/leak_manager.dart';
import 'package:leak_memory_plugin/ui/leak_app.dart';

import 'kit/apm.dart';

void main() async {
  // debugProfileBuildsEnabled = true;

  bool isInDebugMode = false;
  FlutterError.onError = (FlutterErrorDetails details) async {
    // if (isInDebugMode) {
    //   FlutterError.dumpErrorToConsole(details);
    // } else {
    //   print('menggod main: ${details.exception}<--->${details.stack}');
    //
    // }
    print('menggod main: ${details.exception}<--->${details.stack}');
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  // ignore: missing_return
  runZonedGuarded<Future<void>>(() {
    WidgetsFlutterBinding.ensureInitialized();
    // DoKit.runApp(
    //     app: DoKitApp(createApp()),
    //     useInRelease: true,
    //     logCallback: (log) {
    //       String i = log;
    //     },
    //     exceptionCallback: (obj, trace) {
    //       print('ttt$obj');
    //     });
    // LeakManager.instance;
    runApp(LeakApp(createApp()));
    // ApmKitManager.instance.startUp();
    // runApp(createApp());

  }, (Object error, StackTrace stackTrace) async {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    reportError(error, stackTrace);
  });
}

void reportError(Object obj, StackTrace stack) {
  print('menggod reportError: $obj <----> $stack');
}
