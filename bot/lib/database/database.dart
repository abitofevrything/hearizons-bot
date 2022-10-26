import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_postgres/postgres.dart';
import 'package:hearizons/database/converters/duration.dart';
import 'package:hearizons/database/converters/snowflake.dart';
import 'package:hearizons/database/tables.dart';
import 'package:hearizons/hearizons/event_type.dart';
import 'package:nyxx/nyxx.dart';
import 'package:postgres/postgres.dart';

export 'extensions/assignments.dart';
export 'extensions/events.dart';
export 'extensions/relations.dart';
export 'extensions/reviews.dart';
export 'extensions/submissions.dart';

part 'database.g.dart';

LazyDatabase _openConnection() => LazyDatabase(dialect: SqlDialect.postgres, () async {
      PostgreSQLConnection connection = PostgreSQLConnection(
        'database',
        5432,
        Platform.environment['POSTGRES_DB']!,
        username: Platform.environment['POSTGRES_USER']!,
        password: Platform.environment['POSTGRES_PASSWORD']!,
      );

      return PgDatabase(connection);
    });

@DriftDatabase(tables: [Events, CurrentCycles, Cycles, Submissions, Assignments, Reviews])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) => transaction(() async {
          if (from < 2) {
            await m.addColumn(events, events.participantRoleId);
            await m.addColumn(events, events.guildId);
          }
        }),
      );
}
