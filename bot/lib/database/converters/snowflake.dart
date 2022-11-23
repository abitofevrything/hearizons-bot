import 'package:drift/drift.dart';
import 'package:nyxx/nyxx.dart';

class SnowflakeConverter extends TypeConverter<Snowflake, BigInt> {
  const SnowflakeConverter();

  @override
  Snowflake fromSql(BigInt fromDb) => Snowflake(fromDb.toInt());

  @override
  BigInt toSql(Snowflake value) => BigInt.from(value.id);
}
