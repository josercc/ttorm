import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_navigator_paramater.dart';
import 'package:ttorm/ttorm_register.dart';
import 'package:ttorm/ttorm_user_default.dart';

typedef TtormRunEngineAppHandle = Widget Function(StatefulWidget child);

/// Ttorm模块管理器
class Ttorm {
  final TtormRegister register;
  static Ttorm? _ttorm;
  final MethodChannel channel;
  Ttorm()
      : register = TtormRegister(),
        channel = MethodChannel('ttorm') {
    channel.setMethodCallHandler((call) async {
      if (call.method == "push" || call.method == "present") {
        if (call.arguments == null || call.arguments is! String) {
          assert(false, "${call.method}没有带任何参数或者参数不是JSON Text");
          return;
        }
        TtormNavigatorParamater navigatorParamater = TtormNavigatorParamater.from(call.arguments);
        if (navigatorParamater.identifier == null) {
          assert(false, "没有传递模块的标识符");
          return;
        }
        if (call.method == "push") {
          // TtormNavigator.push(TtormIdentifier(navigatorParamater.identifier!), BuildContext());
        }
      }
    });
  }
  static Ttorm manager() {
    if (_ttorm == null) {
      _ttorm = Ttorm();
    }
    return _ttorm!;
  }

  void initModule(Function(TtormRegister register) registerHandle) {
    registerHandle(register);
  }

  Future<String?> _runFlutterViewParameter() async {
    return await TtormUserDefault.getValue("runFlutterView");
  }

  void runApp(Function(Widget child) handle) async {
    String? runFlutterViewParameter = await _runFlutterViewParameter();
    print("runFlutterViewParameter $runFlutterViewParameter");
    if (runFlutterViewParameter == null) {
      assert(false, "runFlutterView没有执行");
      return;
    }

    TtormNavigatorParamater navigatorParamater = TtormNavigatorParamater.from(runFlutterViewParameter);
    if (navigatorParamater.identifier == null) {
      assert(false, "请跳转Flutter前调用runFlutterView方法和设置跳转参数");
      return;
    }
    var child = register.get(TtormIdentifier(navigatorParamater.identifier!), navigatorParamater.parameter);
    if (child == null) {
      assert(false, "${navigatorParamater.identifier!}路由不存在");
    }
    handle(child!);
  }
}
