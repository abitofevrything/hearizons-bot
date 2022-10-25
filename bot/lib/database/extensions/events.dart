import 'dart:async';

import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/database/tables.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:logging/logging.dart';

Expression<DateTime> get currentTime => Variable(DateTime.now());
final Logger _logger = Logger('Database.Events');

extension EventUtils on Database {
  Event _toEvent(EventData data) => data.type.create(data);

  Future<List<Event>> getEventsPendingNewCycle() async {
    final cycleEndTime = DateTimeExpressions.fromUnixEpoch(
      cycles.startedAt.unixepoch + (events.submissionsLength + events.reviewLength),
    );

    final query = select(events).join([
      innerJoin(currentCycles, currentCycles.event.equalsExp(events.id)),
      innerJoin(cycles, currentCycles.cycle.equalsExp(cycles.id)),
    ])
      ..where(cycleEndTime.isSmallerThan(currentTime));

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
      ..where(reviewStartTime.isSmallerThan(currentTime));

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
      ..where(cycles.status.equalsValue(CycleStatus.sumbissions));

    _logger.fine('Getting events with open submissions');

    final rawResults = await query.get();
    final results = rawResults.map((row) => _toEvent(row.readTable(events))).toList();

    _logger.fine('Got ${results.length} events with open submissions => ${results.join(', ')}');

    return results;
  }

  Future<Cycle> moveEventToNextCycle(Event event) => transaction(() async {
        _logger.fine('Moving event ${event.data.id} to new cycle');

        // Create a new cycle
        final cycle = await into(cycles).insertReturning(CyclesCompanion.insert(
          event: event.data.id,
          status: CycleStatus.review,
          startedAt: DateTime.now(),
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
}