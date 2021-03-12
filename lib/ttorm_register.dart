import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_parameter.dart';

typedef TtormRegisterHandle = Widget Function(TtormParameter parameter);

class TtormRegister {
  Map<String, TtormRegisterHandle> _registers = {};
  void register(TtormIdentifier identifier, TtormRegisterHandle handle) async {
    // appModelIdentifiers
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    var appModelIdentifiers = [];
    if (appModelIdentifiers.contains(identifier.identifier)) {
      assert(false, "${identifier.identifier}已经在原生注册");
    } else {
      _registers[identifier.identifier] = handle;
    }
  }

  Widget? get(TtormIdentifier identifier, TtormParameter parameter) {
    TtormRegisterHandle? handle = _registers[identifier.identifier];
    if (handle == null) {
      return null;
    }
    return handle(parameter);
  }

  List<String> getAllRegisterIdentifiers() {
    return _registers.keys.toList();
  }

  /// 获取App原生已经注册的路由
  Future<List<String>> appModelIdentifiers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("appModelIdentifiers") ?? [];
  }
}
