import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:hearizons/database/database.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

Database get database => GetIt.I.get<Database>();

Assignment _extractAssignment(TypedResult result, IContextData _) =>
    result.readTable(database.assignments);
EventData _extractEvent(TypedResult result) => result.readTable(database.events);
Submission _extractSubmission(TypedResult result) => result.readTable(database.submissions);

Future<Iterable<TypedResult>> _getCombinedAssignments(IContextData context) =>
    (database.select(database.assignments).join([
      innerJoin(
        database.submissions,
        database.assignments.submission.equalsExp(database.submissions.id),
      ),
      innerJoin(
        database.cycles,
        database.cycles.id.equalsExp(database.submissions.cycle),
      ),
      innerJoin(
        database.events,
        database.cycles.event.equalsExp(database.events.id),
      ),
    ])
          ..where(
            database.assignments.assignedUser.equalsValue(context.user.id) &
                database.events.active &
                database.assignments.discarded.not() &
                subqueryExpression(database.selectOnly(database.reviews)
                      ..where(
                        database.reviews.submission.equalsExp(database.assignments.submission) &
                            database.reviews.userId.equalsValue(context.user.id),
                      )
                      ..addColumns([countAll()]))
                    .equals(0),
          ))
        .get();

String _combinedAssignmentToString(TypedResult result) {
  final submission = _extractSubmission(result);
  final event = _extractEvent(result);

  final message = '${event.name} | ${submission.content}';

  if (message.length > 100) {
    return message.substring(0, 100);
  }

  return message;
}

const assignedAssignmentConverter = CombineConverter(
  SimpleConverter(
    provider: _getCombinedAssignments,
    stringify: _combinedAssignmentToString,
    sensitivity: 0,
  ),
  _extractAssignment,
);
