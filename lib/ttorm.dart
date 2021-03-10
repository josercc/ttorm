import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttorm/ttorm_register.dart';

typedef TtormRunEngineAppHandle = Widget Function(StatefulWidget child);

class Ttorm {
  final TtormRegister register;
  static Ttorm? _ttorm;
  final MethodChannel channel;
  TtormRunEngineAppHandle? _runEngineAppHandle;
  Ttorm()
      : register = TtormRegister(),
        channel = MethodChannel('ttorm') {
    channel.setMethodCallHandler((call) async {
      if (call.method == "get_all_register_identifiers") {
        return register.getAllRegisterIdentifiers();
      } else if (call.method == "runFlutterView") {}
    });
  }
  static Ttorm manager() {
    if (_ttorm == null) {
      _ttorm = Ttorm();
    }
    return _ttorm!;
  }

  void runApp(TtormRunEngineAppHandle handle) {
    _runEngineAppHandle = handle;
  }
}

@pragma('vm:entry-point')
void ttormRunEngine() {}
