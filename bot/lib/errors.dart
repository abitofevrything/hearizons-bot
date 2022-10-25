import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

class HearizonsException implements Exception {
  final String message;

  HearizonsException(this.message);

  @override
  String toString() => 'Hearizons exception: $message';
}

abstract class UserDisplayedException extends HearizonsException {
  UserDisplayedException(super.message);

  Future<void> handle(IInteractiveContext context);
}

class AlreadySubmittedException extends UserDisplayedException {
  final Event event;
  final List<Submission> existing;

  AlreadySubmittedException({required this.event, required this.existing})
      : super(
          'Duplicate submission ${event.data.name}/${existing.first.userId}',
        );

  @override
  Future<void> handle(IInteractiveContext context) => context.error(
        title: 'Content already submitted',
        content: '''
You've already created a submission for ${event.data.name}. Wait for a new cycle to start before trying again.
''',
      );
}

class PendingReviewsException extends UserDisplayedException {
  final Event event;

  PendingReviewsException(this.event) : super('Pending reviews exist for ${event.data.name}');

  @override
  Future<void> handle(IInteractiveContext context) => context.error(
        title: 'Pending reviews',
        content: '''
You still have pending reviews for ${event.data.name}. Please complete all reviews before submitting again.
''',
      );
}
