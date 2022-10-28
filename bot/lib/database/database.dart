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
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) => transaction(() async {
          if (from < 2) {
            await m.addColumn(events, events.participantRoleId);
            await m.addColumn(events, events.guildId);
          }

          if (from < 3) {
            await (update(events)..where((_) => events.participantRoleId.isNull()))
                .write(EventsCompanion(
              participantRoleId: Value(Snowflake(0)),
            ));

            await (update(events)..where((_) => events.guildId.isNull())).write(EventsCompanion(
              guildId: Value(Snowflake(0)),
            ));

            await customStatement(
                'ALTER TABLE events ALTER COLUMN participant_role_id SET NOT NULL;');
            await customStatement('ALTER TABLE events ALTER COLUMN guild_id DROP DEFAULT;');
          }

          if (from < 4) {
            await m.addColumn(assignments, assignments.discarded);

            await update(assignments).write(AssignmentsCompanion(
              discarded: Value(false),
            ));
          }
        }),
      );
}
