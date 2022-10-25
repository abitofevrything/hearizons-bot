import 'package:drift/drift.dart';
import 'package:nyxx/nyxx.dart';

class SnowflakeConverter extends TypeConverter<Snowflake, int> {
  const SnowflakeConverter();

  @override
  Snowflake fromSql(int fromDb) => Snowflake(fromDb);

  @override
  int toSql(Snowflake value) => value.id;
}
