import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttorm/ttorm.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_parameter.dart';

/// Flutter的路由跳转
class TtormNavigator {
  /// Push进行跳转
  /// - `identifier`: 模块跳转的标识符
  /// - `context`: 当前页面
  /// - `parameter`: 跳转的参数
  /// - `animation`: 是否有动画
  static void push(
    TtormIdentifier identifier,
    BuildContext context, {
    TtormParameter? parameter,
    bool animated = true,
  }) async {
    parameter = parameter ?? TtormParameter.empty();
    Widget? page = Ttorm.manager().register.get(identifier, parameter);
    if (page == null) {
      TtormParameter _parameter = TtormParameter({
        "name": identifier.identifier,
        "parameter": parameter.parameter,
        "animated": animated,
      });
      Ttorm.manager().channel?.invokeMethod("push", _parameter.toJson());
    } else {
      if (Platform.isIOS) {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      }
    }
  }
}
