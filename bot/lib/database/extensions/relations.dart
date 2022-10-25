import 'dart:async';

import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';

// Events, CurrentCycles, Cycles, Submissions, Assignments, Reviews

extension EventRelationships on Database {
  Future<Event> _toEvent(FutureOr<EventData> data) =>
      Future.value(data).then((data) => data.type.create(data));

  Future<Event> getEventFromCycle(Cycle cycle) async {
    final query = select(events)..where((_) => events.id.equals(cycle.event));

    return _toEvent(query.getSingle());
  }

  Future<Event> getEventFromSubmission(Submission submission) async {
    final query = select(submissions).join([
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(submissions.id.equals(submission.id));

    final result = await query.getSingle();
    return _toEvent(result.readTable(events));
  }

  Future<Event> getEventFromAssignment(Assignment assignment) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(assignments.id.equals(assignment.id));

    final result = await query.getSingle();
    return _toEvent(result.readTable(events));
  }

  Future<Event> getEventFromReview(Review review) async {
    final query = select(reviews).join([
      innerJoin(submissions, reviews.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(reviews.id.equals(review.id));

    final result = await query.getSingle();
    return _toEvent(result.readTable(events));
  }
}

extension CycleRelationships on Database {
  Future<List<Cycle>> getCyclesFromEvent(Event event) async {
    final query = select(cycles)..where((_) => cycles.event.equals(event.data.id));

    return query.get();
  }

  Future<Cycle> getCurrentCycle(Event event) async {
    final query = select(cycles).join([
      innerJoin(currentCycles, currentCycles.cycle.equalsExp(cycles.id)),
    ])
      ..where(currentCycles.event.equals(event.data.id));

    final result = await query.getSingle();
    return result.readTable(cycles);
  }

  Future<Cycle> getCycleFromSubmission(Submission submission) async {
    final query = select(cycles)..where((_) => submissions.cycle.equalsExp(cycles.id));

    return query.getSingle();
  }

  Future<Cycle> getCycleFromAssignment(Assignment assignment) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
    ])
      ..where(assignments.id.equals(assignment.id));

    final result = await query.getSingle();
    return result.readTable(cycles);
  }

  Future<Cycle> getCycleFromReview(Review review) async {
    final query = select(reviews).join([
      innerJoin(submissions, reviews.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
    ])
      ..where(reviews.id.equals(review.id));

    final result = await query.getSingle();
    return result.readTable(cycles);
  }
}

extension SubmissionRelationships on Database {
  Future<List<Submission>> getSubmissionsFromEvent(Event event) async {
    final query = select(submissions).join([
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(events.id.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(submissions)).toList();
  }

  Future<List<Submission>> getCurrentSubmissions(Event event) async {
    final query = select(submissions).join([
      innerJoin(currentCycles, currentCycles.cycle.equalsExp(submissions.cycle)),
    ])
      ..where(currentCycles.event.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(submissions)).toList();
  }

  Future<List<Submission>> getSubmissionsFromCycle(Cycle cycle) async {
    final query = select(submissions)..where((_) => submissions.cycle.equals(cycle.id));

    return query.get();
  }

  Future<Submission> getSubmissionFromAssignment(Assignment assignment) async {
    final query = select(submissions)..where((_) => submissions.id.equals(assignment.submission));

    return query.getSingle();
  }

  Future<Submission> getSubmissionFromReview(Review review) async {
    final query = select(submissions)..where((_) => submissions.id.equals(review.submission));

    return query.getSingle();
  }
}

extension AssignmentRelationships on Database {
  Future<List<Assignment>> getAssignmentsFromEvent(Event event) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(events.id.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(assignments)).toList();
  }

  Future<List<Assignment>> getCurrentAssignments(Event event) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(currentCycles, submissions.cycle.equalsExp(currentCycles.cycle)),
    ])
      ..where(currentCycles.event.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(assignments)).toList();
  }

  Future<List<Assignment>> getAssignmentsFromCycle(Cycle cycle) async {
    final query = select(assignments).join([
      innerJoin(submissions, assignments.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
    ])
      ..where(cycles.id.equals(cycle.id));

    final result = await query.get();
    return result.map((row) => row.readTable(assignments)).toList();
  }

  Future<List<Assignment>> getAssignmentsFromSubmission(Submission submission) async {
    final query = select(assignments)..where((_) => assignments.submission.equals(submission.id));

    return query.get();
  }
}

extension ReviewRelationships on Database {
  Future<List<Review>> getReviewsFromEvent(Event event) async {
    final query = select(reviews).join([
      innerJoin(submissions, reviews.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
      innerJoin(events, cycles.event.equalsExp(events.id)),
    ])
      ..where(events.id.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(reviews)).toList();
  }

  Future<List<Review>> getCurrentReviews(Event event) async {
    final query = select(reviews).join([
      innerJoin(submissions, reviews.submission.equalsExp(submissions.id)),
      innerJoin(currentCycles, submissions.cycle.equalsExp(currentCycles.cycle)),
    ])
      ..where(currentCycles.event.equals(event.data.id));

    final result = await query.get();
    return result.map((row) => row.readTable(reviews)).toList();
  }

  Future<List<Review>> getReviewsFromCycle(Cycle cycle) async {
    final query = select(reviews).join([
      innerJoin(submissions, reviews.submission.equalsExp(submissions.id)),
      innerJoin(cycles, submissions.cycle.equalsExp(cycles.id)),
    ])
      ..where(cycles.id.equals(cycle.id));

    final result = await query.get();
    return result.map((row) => row.readTable(reviews)).toList();
  }

  Future<List<Review>> getReviewsFromSubmission(Submission submission) async {
    final query = select(reviews)..where((_) => reviews.submission.equals(submission.id));

    return query.get();
  }
}
