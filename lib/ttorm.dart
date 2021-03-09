import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttorm/ttorm_register.dart';

class Ttorm {
  final TtormRegister register;
  static Ttorm? _ttorm;
  final MethodChannel channel;
  Ttorm()
      : register = TtormRegister(),
        channel = MethodChannel('ttorm') {
    channel.setMethodCallHandler((call) async {
      if (call.method == "get_all_register_identifiers") {
        return register.getAllRegisterIdentifiers();
      }
    });
  }
  static Ttorm manager() {
    if (_ttorm == null) {
      _ttorm = Ttorm();
    }
    return _ttorm!;
  }
}

@pragma('vm:entry-point')
void ttormRunEngine() {
  runApp(CupertinoApp(
    builder: (context, child) => Container(),
  ));
}
