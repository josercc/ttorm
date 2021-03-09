import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttorm/ttorm.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_parameter.dart';
import 'package:ttorm/ttorm_register.dart';

class TtormNavigator {
  static void push(
    TtormIdentifier identifier,
    BuildContext context, {
    TtormParameter? parameter,
    bool animation = true,
    bool isFromFlutter = true,
  }) async {
    StatefulWidget? page = Ttorm.manager().register.get(identifier, parameter ?? TtormParameter.empty());
    if (page == null) {
      var identifier = await Ttorm.manager().channel.invokeMethod("get_all_register_identifiers");
      if (identifier! is List<String>) {
        assert(false, "$identifier没有实现");
      } else {}
    } else {
      if (Platform.isIOS) {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      }
    }
  }
}
