import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_postgres/postgres.dart';
import 'package:hearizons/database/converters/duration.dart';
import 'package:hearizons/database/converters/snowflake.dart';
import 'package:hearizons/database/tables.dart';
import 'package:hearizons/hearizons/event_type.dart';
import 'package:nyxx/nyxx.dart';
import 'package:postgres/postgres.dart';
import 'extensions/events.dart';
import 'extensions/relations.dart';

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

@DriftDatabase(tables: [
  Events,
  EventDependencies,
  CurrentCycles,
  Cycles,
  Submissions,
  Assignments,
  Reviews,
])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) => transaction(() async {
          final postUpgradeCallbacks = <Future<void> Function()>[];

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
            await customStatement('UPDATE assignments SET discarded = false;');
          }

          if (from < 5) {
            await m.createTable(eventDependencies);
          }

          if (from < 6) {
            await customStatement(
              '''ALTER TABLE cycles
                  ADD COLUMN submissions_event_id INTEGER,
                  ADD COLUMN reviews_event_id INTEGER,
                  ADD COLUMN next_cycle_submissions_event_id INTEGER;''',
            );

            await customStatement(
              '''UPDATE cycles SET
                   submissions_event_id = 0,
                   reviews_event_id = 0,
                   next_cycle_submissions_event_id = 0;''',
            );

            postUpgradeCallbacks.add(() async {
              for (final event in await getActiveEvents()) {
                final currentCycle = await getCurrentCycle(event);
                final events = await event.createSubmissionsReviewsAndNextCycleEvents(
                  currentCycle.startedAt,
                );

                final update = this.update(cycles)..whereSamePrimaryKey(currentCycle);
                await update.write(CyclesCompanion(
                  submissionsEventId: Value(events[0]),
                  reviewsEventId: Value(events[1]),
                  nextCycleSubmissionsEventId: Value(events[2]),
                ));
              }
            });

            await customStatement(
              '''ALTER TABLE cycles
                   ALTER COLUMN submissions_event_id SET NOT NULL,
                   ALTER COLUMN reviews_event_id SET NOT NULL,
                   ALTER COLUMN next_cycle_submissions_event_id SET NOT NULL;''',
            );
          }

          if (from < 7) {
            await customStatement(
              '''ALTER TABLE events
                   ALTER COLUMN announcements_channel_id SET DATA TYPE bigint,
                   ALTER COLUMN reviews_channel_id SET DATA TYPE bigint,
                   ALTER COLUMN participant_role_id SET DATA TYPE bigint,
                   ALTER COLUMN guild_id SET DATA TYPE bigint;''',
            );

            await customStatement(
              '''ALTER TABLE cycles
                   ALTER COLUMN submissions_event_id SET DATA TYPE bigint,
                   ALTER COLUMN reviews_event_id SET DATA TYPE bigint,
                   ALTER COLUMN next_cycle_submissions_event_id SET DATA TYPE bigint;''',
            );

            await customStatement(
                'ALTER TABLE submissions ALTER COLUMN user_id SET DATA TYPE bigint;');
            await customStatement(
                'ALTER TABLE assignments ALTER COLUMN assigned_user SET DATA TYPE bigint;');
            await customStatement('ALTER TABLE reviews ALTER COLUMN user_id SET DATA TYPE bigint;');
          }

          if (from < 8) {
            await customStatement('ALTER TABLE cycles ADD COLUMN status_message_id bigint;');
            await customStatement('UPDATE cycles SET status_message_id = 0;');
            await customStatement(
                'ALTER TABLE cycles ALTER COLUMN status_message_id SET NOT NULL;');
          }

          if (from < 9) {
            await customStatement('ALTER TABLE events ADD COLUMN announcement_role_id bigint;');
            await customStatement('UPDATE events SET announcement_role_id = 0;');
            await customStatement(
                'ALTER TABLE events ALTER COLUMN announcement_role_id SET NOT NULL;');
          }

          await Future.wait(postUpgradeCallbacks.map((f) => f()));
        }),
      );
}
