class TtormParameter {
  final Map<String, dynamic> parameter;
  TtormParameter(this.parameter);
  TtormParameter.empty() : this.parameter = {};
  TtormParameter.fromDynamicMap(Map<dynamic, dynamic> map)
      : this.parameter =
            map.map((key, value) => MapEntry(key.toString(), value));

  T? get<T>(String key) {
    dynamic? value = parameter[key];
    if (value != null && value! is T) {
      return value as T;
    } else {
      return null;
    }
  }

  T getLate<T>(String key, T defaultValue) {
    return get(key) ?? defaultValue;
  }
}
