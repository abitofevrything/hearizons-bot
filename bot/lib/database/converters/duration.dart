import 'package:drift/drift.dart';

class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromSql(int fromDb) => Duration(seconds: fromDb);

  @override
  int toSql(Duration value) => value.inSeconds;
}
