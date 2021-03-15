import 'package:flutter/material.dart';
import 'package:ttorm/ttorm.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm_example/a_page.dart';
import 'package:ttorm_example/b_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Ttorm.manager().initModule((register) {
    register.register(TtormIdentifier("APage"),
        (parameter) => APage(name: parameter.getLate("name", "Hello World")));
    register.register(TtormIdentifier("BPage"), (parameter) => BPage());
  });
  runApp(MaterialApp(onGenerateRoute: (setting) {
    print("setting ${setting.name}");
    return MaterialPageRoute(
        builder: (context) =>
            Ttorm.manager().runApp(setting.name!, context) ?? Container());
  }));
}
