import 'package:flutter/material.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_parameter.dart';

typedef TtormRegisterHandle = Widget Function(TtormParameter parameter);

class TtormRegister {
  Map<String, TtormRegisterHandle> _registers = {};
  void register(TtormIdentifier identifier, TtormRegisterHandle handle) async {
    if (getAllRegisterIdentifiers.contains(identifier.identifier)) {
      assert(false, "${identifier.identifier}已经在原生注册");
      return;
    }
    _registers[identifier.identifier] = handle;
  }

  Widget? get(TtormIdentifier identifier, TtormParameter parameter) {
    TtormRegisterHandle? handle = _registers[identifier.identifier];
    if (handle == null) {
      return null;
    }
    return handle(parameter);
  }

  List<String> get getAllRegisterIdentifiers {
    return _registers.keys.toList();
  }
}
