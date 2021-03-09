import 'package:flutter/material.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_parameter.dart';

typedef TtormRegisterHandle = StatefulWidget Function(TtormParameter parameter);

class TtormRegister {
  Map<String, TtormRegisterHandle> _registers = {};
  void register(TtormIdentifier identifier, TtormRegisterHandle handle) {
    _registers[identifier.identifier] = handle;
  }

  StatefulWidget? get(TtormIdentifier identifier, TtormParameter parameter) {
    TtormRegisterHandle? handle = _registers[identifier.identifier];
    if (handle == null) {
      return null;
    }
    return handle(parameter);
  }

  List<String> getAllRegisterIdentifiers() {
    return _registers.keys.toList();
  }
}
