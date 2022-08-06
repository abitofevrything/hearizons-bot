import 'package:freezed_annotation/freezed_annotation.dart';

class SqliteBoolConverter implements JsonConverter<bool, int> {
  const SqliteBoolConverter();

  @override
  bool fromJson(int json) => json != 0;

  @override
  int toJson(bool object) => object ? 1 : 0;
}
