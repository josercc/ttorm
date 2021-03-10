import 'dart:convert';

import 'package:ttorm/ttorm_parameter.dart';

class TtormNavigatorParamater {
  final String? identifier;
  final TtormParameter parameter;
  TtormNavigatorParamater.from(String source)
      : this.identifier = parseIdentifier(source),
        this.parameter = parseParameter(source);

  static String? parseIdentifier(String source) {
    Map<String, dynamic> map = json.decode(source);
    return map["identifier"];
  }

  static TtormParameter parseParameter(String source) {
    Map<String, dynamic> map = json.decode(source);
    var parameter = map["parameter"];
    if (parameter is Map<String, dynamic>) {
      return TtormParameter(parameter);
    } else {
      return TtormParameter.empty();
    }
  }
}
