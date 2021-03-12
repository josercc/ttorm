import 'dart:convert';

import 'package:ttorm/ttorm_parameter.dart';

/// 进行跳转对应的参数
class TtormNavigatorParamater {
  /// 模块的标识符
  final String? identifier;

  /// 跳转的参数
  final TtormParameter parameter;

  /// 从原生JSON文本解析出跳转参数
  TtormNavigatorParamater.from(String source)
      : this.identifier = parseIdentifier(source),
        this.parameter = parseParameter(source);

  /// 解析出模块对应标识符
  static String? parseIdentifier(String source) {
    Map<String, dynamic> map = json.decode(source);
    return map["identifier"];
  }

  /// 解析模块跳转的参数
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
