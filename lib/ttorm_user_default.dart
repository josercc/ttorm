import 'package:ttorm/ttorm.dart';
import 'package:ttorm/ttorm_parameter.dart';

class TtormUserDefault {
  static Future<String> getValue(String key) async {
    return await Ttorm.manager().channel.invokeMethod("getValue", TtormParameter({"key": key}).toJson());
  }
}
