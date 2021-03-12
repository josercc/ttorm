import 'package:flutter/material.dart';
import 'package:ttorm/ttorm.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm_example/a_page.dart';
import 'package:ttorm_example/b_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Ttorm.manager().initModule((register) {
    register.register(TtormIdentifier("APage"), (parameter) => APage());
    register.register(TtormIdentifier("BPage"), (parameter) => BPage());
  });
  runApp(MaterialApp(
    routes: {"APage": (context) => APage(), "BPage": (context) => BPage()},
  ));
}

// print("${settings.name}  ${settings.arguments}");
//       if (settings.name == null) {
//         assert(false, "RouteSettings name不存在");
//         return null;
//       }
//       if (settings.arguments is! String) {
//         assert(false, "arguments必须是一个JSON字符串");
//         return null;
//       }
//       Map argumentsMap = json.decode(settings.arguments as String);
//       Widget? page =
//           Ttorm.manager().register.get(TtormIdentifier(settings.name!), TtormParameter.fromDynamicMap(argumentsMap));
//       if (page == null) {
//         assert(false, "${settings.name!}路由没有注册");
//         return null;
//       }
//       return MaterialPageRoute(builder: (context) => page);
