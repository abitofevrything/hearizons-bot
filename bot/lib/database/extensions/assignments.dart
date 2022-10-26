import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';

final Logger _logger = Logger('Database.Assignments');

extension AssignmentUtils on Database {
  Future<void> createAssignments(List<AssignmentsCompanion> assignments) {
    _logger.fine('Creating ${assignments.length} assignments => ${assignments.join(', ')}');

    return batch(
      (batch) => batch.insertAll(this.assignments, assignments),
    );
  }

  Future<List<Assignment>> getIncompleteAssignmentsForUserInEvent(
    Event event,
    Snowflake userId,
  ) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
    ])
      ..where(
        // Ensure event matches
        cycles.event.equals(event.data.id) &
            // Ensure user matches
            assignments.assignedUser.equalsValue(userId) &
            // Ensure assignment has no corresponding review
            subqueryExpression(selectOnly(reviews)
                  ..addColumns([countAll()])
                  ..where(
                    reviews.submission.equalsExp(assignments.submission) &
                        reviews.userId.equalsExp(assignments.assignedUser),
                  ))
                .equals(0),
      );

    _logger.fine('Getting incomplete assignments for user => user: $userId event: $event');

    final rawResult = await query.get();
    final result = rawResult.map((row) => row.readTable(assignments)).toList();

    _logger.fine(
      'Got ${result.length} incomplete assignments => user: $userId event: $event result: ${result.join(', ')}',
    );

    return result;
  }
}
