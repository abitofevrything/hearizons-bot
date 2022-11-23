import 'package:drift/drift.dart';
import 'package:hearizons/database/converters/duration.dart';
import 'package:hearizons/database/converters/snowflake.dart';
import 'package:hearizons/hearizons/event_type.dart';

/// An event in the Hearizons project.
@DataClassName('EventData')
class Events extends Table {
  /// The id of the event.
  IntColumn get id => integer().autoIncrement()();

  /// The name of the event.
  TextColumn get name => text()();

  /// Whether the event is active.
  BoolColumn get active => boolean()();

  /// The type of event.
  IntColumn get type => intEnum<EventType>()();

  /// The length of one cycle's submission phase.
  IntColumn get submissionsLength => integer().map(const DurationConverter())();

  /// The length of one cycle's review phase.
  IntColumn get reviewLength => integer().map(const DurationConverter())();

  /// The id of the channel to send announcements to.
  IntColumn get announcementsChannelId => integer().map(const SnowflakeConverter())();

  /// The id of the channel to send reviews to.
  IntColumn get reviewsChannelId => integer().map(const SnowflakeConverter())();

  /// The id of the role to give participants.
  IntColumn get participantRoleId => integer().map(const SnowflakeConverter())();

  /// The id of the guild in which this event occurs.
  IntColumn get guildId => integer().map(const SnowflakeConverter())();
}

class EventDependencies extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// The event for which this dependency is declared.
  IntColumn get event => integer().references(Events, #id)();

  /// The depdencency.
  IntColumn get dependency => integer().references(Events, #id)();
}

class CurrentCycles extends Table {
  IntColumn get event => integer().references(Events, #id)();
  IntColumn get cycle => integer().references(Cycles, #id)();
}

enum CycleStatus {
  /// The cycle is currently open for submissions.
  submissions,

  /// The cycle is currently open for reviews.
  review,
}

/// A cycle, consisting of a submission phase and a review phase, of an event.
class Cycles extends Table {
  /// The id of the cycle.
  IntColumn get id => integer().autoIncrement()();

  /// The event to which this cycle belongs.
  IntColumn get event => integer().references(Events, #id)();

  /// The current status of this cycle.
  IntColumn get status => intEnum<CycleStatus>()();

  /// The time at which the current cycle started.
  DateTimeColumn get startedAt => dateTime()();

  /// The ID of the guild event representing this cycle's submissions
  IntColumn get submissionsEventId => integer().map(const SnowflakeConverter())();

  /// The ID of the guild event representing this cycle's reviews
  IntColumn get reviewsEventId => integer().map(const SnowflakeConverter())();

  /// The ID of the guild event representing the next cycle's submissions
  IntColumn get nextCycleSubmissionsEventId => integer().map(const SnowflakeConverter())();
}

/// A submission to a cycle.
class Submissions extends Table {
  /// The id of the submission.
  IntColumn get id => integer().autoIncrement()();

  /// The cycle to which this submission belongs.
  IntColumn get cycle => integer().references(Cycles, #id)();

  /// The ID of the user who submitted this content.
  IntColumn get userId => integer().map(const SnowflakeConverter())();

  /// The content of the submission.
  TextColumn get content => text()();
}

/// An assignment for a user to review a submission.
class Assignments extends Table {
  /// The id of the assignment.
  IntColumn get id => integer().autoIncrement()();

  /// The submission to review.
  IntColumn get submission => integer().references(Submissions, #id)();

  /// The user who should perform the review.
  IntColumn get assignedUser => integer().map(const SnowflakeConverter())();

  /// Whether this assignment was discarded despite not being completed.
  BoolColumn get discarded => boolean().withDefault(Constant(false))();
}

/// A review of a submission.
class Reviews extends Table {
  /// The id of this review.
  IntColumn get id => integer().autoIncrement()();

  /// The submission to which this review belongs.
  IntColumn get submission => integer().references(Submissions, #id)();

  /// The ID of the user who submitted this review.
  IntColumn get userId => integer().map(const SnowflakeConverter())();

  /// The content of the review.
  TextColumn get content => text()();
}
