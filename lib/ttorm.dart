import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_navigator.dart';
import 'package:ttorm/ttorm_navigator_paramater.dart';
import 'package:ttorm/ttorm_parameter.dart';
import 'package:ttorm/ttorm_register.dart';

typedef TtormRunEngineAppHandle = Widget Function(StatefulWidget child);

/// Ttorm模块管理器
class Ttorm {
  final TtormRegister register;
  static Ttorm? _ttorm;
  MethodChannel? channel;
  BuildContext? _context;
  Ttorm() : register = TtormRegister();
  static Ttorm manager() {
    if (_ttorm == null) {
      _ttorm = Ttorm();
    }
    return _ttorm!;
  }

  void initModule(Function(TtormRegister register) registerHandle) {
    registerHandle(register);
  }

  Widget? runApp(
    String route,
    BuildContext context,
  ) {
    _context = context;
    Uri uri = Uri.parse(route);
    String? name = uri.queryParameters["name"];
    String? arguments = uri.queryParameters["arguments"];
    String? channelName = uri.queryParameters["channel"];
    if (name == null || channelName == null) {
      assert(false, "没有设置name参数 或者没有设置channel");
      return null;
    }
    channel = MethodChannel(channelName);
    channel?.setMethodCallHandler((call) async {
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
        if (call.method == "push" && _context != null) {
          TtormNavigator.push(TtormIdentifier(navigatorParamater.identifier!), _context!);
        }
      }
    });
    var child = register.get(TtormIdentifier(name),
        arguments == null ? TtormParameter.empty() : TtormParameter.fromDynamicMap(json.decode(arguments)));
    if (child == null) {
      assert(false, "$name路由不存在");
    }
    return child;
  }
}
