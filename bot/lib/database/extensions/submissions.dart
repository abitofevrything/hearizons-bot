import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';

final Logger _logger = Logger('Database.Submissions');

extension SubmissionUtils on Database {
  Future<List<Submission>> getCurrentSubmissionsFromUser(Event event, Snowflake userId) async {
    final query = select(submissions).join([
      innerJoin(currentCycles, submissions.cycle.equalsExp(currentCycles.cycle)),
    ])
      ..where(currentCycles.event.equals(event.data.id) & submissions.userId.equalsValue(userId));

    _logger.fine('Getting current submissions for user in event => userId: $userId event: $event');

    final rawResult = await query.get();
    final result = rawResult.map((row) => row.readTable(submissions)).toList();

    _logger.fine(
      'Got ${result.length} current submissions for user in event => userId: $userId event: $event result: ${result.join(', ')}',
    );

    return result;
  }

  Future<Submission> createSubmission(SubmissionsCompanion submission) {
    _logger.fine('Creating submission => $submission');

    return into(submissions).insertReturning(submission);
  }
}

extension SubmissionX on Submission {
  String get displayedContent {
    final content = StringBuffer();

    if (title != null) {
      content.write(title);

      if (artist != null) {
        content.write(' by $artist');
      }

      if (url != null) {
        content.write(' (<$url>)');
      }
    } else if (url != null) {
      content.write('<$url>');
    } else {
      content.write(this.content);
    }

    return content.toString();
  }
}
