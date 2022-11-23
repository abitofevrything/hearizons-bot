import 'dart:async';

import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/database/tables.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';

Expression<DateTime> get currentTime => Variable(DateTime.now());
final Logger _logger = Logger('Database.Events');

extension EventUtils on Database {
  Event _toEvent(EventData data) => data.type.create(data);

  Future<List<Event>> getActiveEvents() async {
    final query = select(events)..where((_) => events.active);

    final rawResults = await query.get();
    final results = rawResults.map((row) => _toEvent(row)).toList();

    return results;
  }

  Future<List<Event>> getEventsPendingNewCycle() async {
    final cycleEndTime = DateTimeExpressions.fromUnixEpoch(
      cycles.startedAt.unixepoch + (events.submissionsLength + events.reviewLength),
    );

    final query = select(events).join([
      innerJoin(currentCycles, currentCycles.event.equalsExp(events.id)),
      innerJoin(cycles, currentCycles.cycle.equalsExp(cycles.id)),
    ])
      ..where(cycleEndTime.isSmallerThan(currentTime) & events.active);

    _logger.fine('Getting events pending new cycles');

    final rawResults = await query.get();
    final results = rawResults.map((row) => _toEvent(row.readTable(events))).toList();

    _logger.fine('Got ${results.length} events pending new cycles => ${results.join(', ')}');

    return results;
  }

  Future<List<Event>> getEventsPendingReviewPhase() async {
    final reviewStartTime = DateTimeExpressions.fromUnixEpoch(
      cycles.startedAt.unixepoch + events.submissionsLength,
    );

    final query = select(events).join([
      innerJoin(currentCycles, currentCycles.event.equalsExp(events.id)),
      innerJoin(cycles, currentCycles.cycle.equalsExp(cycles.id)),
    ])
      ..where(
        reviewStartTime.isSmallerThan(currentTime) &
            cycles.status.equalsValue(CycleStatus.submissions) &
            events.active,
      );

    _logger.fine('Getting events pending review phases');

    final rawResults = await query.get();
    final results = rawResults.map((row) => _toEvent(row.readTable(events))).toList();

    _logger.fine('Got ${results.length} events pending review phases => ${results.join(', ')}');

    return results;
  }

  Future<List<Event>> getEventsWithOpenSubmissions() async {
    final query = select(events).join([
      innerJoin(currentCycles, currentCycles.event.equalsExp(events.id)),
      innerJoin(cycles, currentCycles.cycle.equalsExp(cycles.id)),
    ])
      ..where(cycles.status.equalsValue(CycleStatus.submissions) & events.active);

    _logger.fine('Getting events with open submissions');

    final rawResults = await query.get();
    final results = rawResults.map((row) => _toEvent(row.readTable(events))).toList();

    _logger.fine('Got ${results.length} events with open submissions => ${results.join(', ')}');

    return results;
  }

  Future<List<Event>> getManageableEvents(Snowflake guildId) async {
    final query = select(events)..where((_) => events.guildId.equalsValue(guildId));

    _logger.fine('Getting manageable events => guildId: $guildId');

    final rawResult = await query.get();
    final results = rawResult.map(_toEvent).toList();

    _logger.fine(
      'Got ${results.length} manageable events => guildId: $guildId results: ${results.join(', ')}',
    );

    return results;
  }

  Future<Cycle> startCycleForEvent(
    Event event, {
    required Snowflake submissionsEventId,
    required Snowflake reviewsEventId,
    required Snowflake nextSubmissionsEventId,
  }) =>
      transaction(() async {
        _logger.fine('Creating new cycle for event ${event.data.id}');

        final cycle = await into(cycles).insertReturning(CyclesCompanion.insert(
          event: event.data.id,
          status: CycleStatus.submissions,
          startedAt: DateTime.now(),
          nextCycleSubmissionsEventId: nextSubmissionsEventId,
          reviewsEventId: reviewsEventId,
          submissionsEventId: submissionsEventId,
        ));

        final update = this.update(currentCycles)
          ..where((_) => currentCycles.event.equals(event.data.id));

        int updated = await update.write(CurrentCyclesCompanion(cycle: Value(cycle.id)));
        if (updated == 0) {
          await into(currentCycles).insert(CurrentCyclesCompanion.insert(
            event: event.data.id,
            cycle: cycle.id,
          ));
        }

        _logger.fine('Created new cycle for event ${event.data.id} => $cycle');

        return cycle;
      });

  Future<DateTime> getNextCycleStart(Event event) async {
    final previousCycle = await getCurrentCycle(event);

    final previousCycleStart = previousCycle.startedAt;
    final nextCycleStart =
        previousCycleStart.add(event.data.submissionsLength).add(event.data.reviewLength);

    // Don't allow short cycles to build up
    final minimumStartTime = DateTime.now().subtract(const Duration(hours: 1));

    return minimumStartTime.isAfter(nextCycleStart) ? minimumStartTime : nextCycleStart;
  }

  Future<Cycle> moveEventToNextCycle(
    Event event, {
    required Snowflake nextCycleSubmissionsEventId,
    required Snowflake reviewsEventId,
  }) =>
      transaction(() async {
        _logger.fine('Moving event ${event.data.id} to new cycle');

        final previousCycle = await getCurrentCycle(event);
        // Create a new cycle
        final cycle = await into(cycles).insertReturning(CyclesCompanion.insert(
          event: event.data.id,
          status: CycleStatus.submissions,
          startedAt: await getNextCycleStart(event),
          nextCycleSubmissionsEventId: nextCycleSubmissionsEventId,
          reviewsEventId: reviewsEventId,
          submissionsEventId: previousCycle.nextCycleSubmissionsEventId,
        ));

        // Update the entry in the current cycles table

        final update = this.update(
          currentCycles,
        )..where((_) => currentCycles.event.equals(event.data.id));

        await update.write(CurrentCyclesCompanion(cycle: Value(cycle.id)));

        _logger.fine('Moved event ${event.data.id} to new cycle => $cycle');

        return cycle;
      });

  Future<Cycle> moveEventToReviewPhase(Event event) async {
    final update = this.update(cycles)
      ..where((_) => cycles.id.equalsExp(subqueryExpression(selectOnly(currentCycles)
        ..addColumns([currentCycles.cycle])
        ..where(currentCycles.event.equals(event.data.id)))));

    _logger.fine('Moving event ${event.data.id} to review phase');

    final rawResult =
        await update.writeReturning(CyclesCompanion(status: Value(CycleStatus.review)));
    final result = rawResult.single;

    _logger.fine('Moved event ${event.data.id} to review phase => $result');

    return result;
  }

  Future<Event> createEvent(EventsCompanion event) async {
    _logger.fine('Creating event $event');

    return _toEvent(await into(events).insertReturning(event));
  }

  Future<Event> updateEvent(Insertable<EventData> event) async {
    _logger.fine('Updating event $event');

    final update = this.update(events)..whereSamePrimaryKey(event);

    final rawResult = await update.writeReturning(event);
    return _toEvent(rawResult.single);
  }

  Future<List<Event>> getDependenciesOf(Event event) async {
    _logger.fine('Getting dependencies for event ${event.data.id}');

    final query = select(eventDependencies).join([
      innerJoin(events, eventDependencies.dependency.equalsExp(events.id)),
    ])
      ..where(eventDependencies.event.equals(event.data.id));

    final rawResult = await query.get();
    final result = rawResult.map((row) => _toEvent(row.readTable(events))).toList();

    _logger.fine('Got dependencies for event ${event.data.id} => [${result.join(', ')}]');

    return result;
  }

  Future<List<Event>> getLinkeableEvents(Event event) async {
    _logger.fine('Getting linkeable events for event ${event.data.id}');

    final query = select(events)
      ..where(
        (_) =>
            events.guildId.equalsValue(event.data.guildId) &
            events.id.equals(event.data.id).not() &
            events.id.isNotInQuery(
              selectOnly(eventDependencies)
                ..addColumns([eventDependencies.dependency])
                ..where(eventDependencies.event.equalsExp(events.id)),
            ),
      );

    final rawResult = await query.get();
    final result = rawResult.map((row) => _toEvent(row)).toList();

    _logger.fine('Got linkeable events for event ${event.data.id} => [${result.join(', ')}]');

    return result;
  }

  Future<void> link(Event event, Event dependency) async {
    await into(eventDependencies).insert(EventDependenciesCompanion.insert(
      event: event.data.id,
      dependency: dependency.data.id,
    ));
  }

  Future<void> unlink(Event event, Event dependency) async {
    final query = delete(eventDependencies)
      ..where((_) =>
          eventDependencies.event.equals(event.data.id) &
          eventDependencies.dependency.equals(dependency.data.id));

    await query.go();
  }
}
