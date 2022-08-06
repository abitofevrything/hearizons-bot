import 'package:hearizons_bot/src/models/assigned_reviewer.dart';
import 'package:hearizons_bot/src/models/hearizons.dart';
import 'package:hearizons_bot/src/models/review.dart';
import 'package:hearizons_bot/src/models/submission.dart';
import 'package:sqlite3/sqlite3.dart' hide Database;
import 'package:sqlite3/sqlite3.dart' as sqlite show Database;

Database initializeDatabase() {
  Database db = Database(sqlite3.open('database.db'));
  db.runMigrations();
  db.populateCache();
  return db;
}

class Database {
  final sqlite.Database database;

  final Map<int, Hearizons> _hearizonsCache = {};
  final Map<int, Submission> _submissionCache = {};
  final Map<int, Review> _reviewCache = {};
  final Map<int, AssignedReviewer> _assignedReviewerCache = {};

  Iterable<Hearizons> get hearizons => _hearizonsCache.values;
  Iterable<Hearizons> get activeHearizons =>
      _hearizonsCache.values.where((hearizons) => !hearizons.closed);
  Iterable<Hearizons> get submittingHearizons =>
      activeHearizons.where((hearizons) => !hearizons.inReview);
  Iterable<Hearizons> get reviewingHearizons =>
      activeHearizons.where((hearizons) => hearizons.inReview);

  Iterable<Submission> get submissions => _submissionCache.values;

  Iterable<Review> get reviews => _reviewCache.values;

  Iterable<AssignedReviewer> get assignedReviewers => _assignedReviewerCache.values;
  Iterable<AssignedReviewer> get missingReviews =>
      _assignedReviewerCache.values.where((assignedReviewer) => assignedReviewer.reviewId == null);

  Hearizons getHearizons(int id) => _hearizonsCache[id]!;
  Submission getSubmission(int id) => _submissionCache[id]!;
  Review getReview(int id) => _reviewCache[id]!;
  AssignedReviewer getAssignedReviewer(int id) => _assignedReviewerCache[id]!;

  Database(this.database);

  void runMigrations() {
    int version = database.select('PRAGMA user_version;').first.values.first;

    if (version < 1) {
      database.execute('''
        CREATE TABLE IF NOT EXISTS hearizons (
          id        INTEGER PRIMARY KEY NOT NULL,
          name      TEXT                NOT NULL UNIQUE,
          in_review INTEGER             NOT NULL        DEFAULT 0,
          phase     INTEGER             NOT NULL        DEFAULT 0,
          closed    INTEGER             NOT NULL        DEFAULT 0
        );

        CREATE TABLE IF NOT EXISTS submissions (
          id       INTEGER PRIMARY KEY NOT NULL,
          hearizons_id INTEGER             NOT NULL,
          phase_id INTEGER             NOT NULL,
          user_id  INTEGER             NOT NULL,
          url      TEXT                NOT NULL,
          FOREIGN KEY(hearizons_id) REFERENCES hearizons(hearizons_id),
          UNIQUE(hearizons_id, phase_id, user_id)
        );

        CREATE TABLE IF NOT EXISTS reviews (
          id            INTEGER PRIMARY KEY NOT NULL,
          submission_id INTEGER             NOT NULL UNIQUE,
          user_id       INTEGER             NOT NULL,
          content       TEXT                NOT NULL,
          FOREIGN KEY(submission_id) REFERENCES submissions(submission_id)
        );

        CREATE TABLE IF NOT EXISTS assigned_reviewers (
          id            INTEGER PRIMARY KEY NOT NULL,
          submission_id INTEGER             NOT NULL,
          user_id       INTEGER             NOT NULL,
          review_id     INTEGER,
          FOREIGN KEY(submission_id) REFERENCES submissions(submission_id),
          FOREIGN KEY(review_id) REFERENCES reviews(review_id),
          UNIQUE(submission_id, review_id)
        );
      ''');
      database.execute('PRAGMA user_version = 1;');
    }

    return;
  }

  void populateCache() {
    _hearizonsCache.clear();
    _submissionCache.clear();
    _reviewCache.clear();
    _assignedReviewerCache.clear();

    _hearizonsCache.addEntries(database
        .select('SELECT * FROM hearizons;')
        .map((row) => MapEntry(row['id'], Hearizons.fromJson(row))));
    _submissionCache.addEntries(database
        .select('SELECT * FROM submissions;')
        .map((row) => MapEntry(row['id'], Submission.fromJson(row))));
    _reviewCache.addEntries(database
        .select('SELECT * FROM reviews;')
        .map((row) => MapEntry(row['id'], Review.fromJson(row))));
    _assignedReviewerCache.addEntries(database
        .select('SELECT * FROM assigned_reviewers;')
        .map((row) => MapEntry(row['id'], AssignedReviewer.fromJson(row))));
  }

  void upsertHearizons(Hearizons hearizons) {
    if (hearizons.id == null) {
      int id = database
          .select('''
        INSERT INTO hearizons (name, in_review, phase, closed)
        VALUES (?, ?, ?, ?)
        RETURNING id;
      ''', [hearizons.name, hearizons.inReview, hearizons.phase, hearizons.closed])
          .first
          .values
          .first;

      _hearizonsCache[id] = hearizons.copyWith(id: id);
    } else {
      database.execute('''
        UPDATE hearizons SET
          name = ?,
          in_review = ?,
          phase = ?,
          closed = ?
        WHERE id = ?;
      ''', [hearizons.name, hearizons.inReview, hearizons.phase, hearizons.closed, hearizons.id]);

      _hearizonsCache[hearizons.id!] = hearizons;
    }
  }

  void upsertSubmission(Submission submission) {
    if (submission.id == null) {
      int id = database
          .select(
            '''
              INSERT INTO submissions (hearizons_id, phase_id, user_id, url)
              VALUES (?, ?, ?, ?)
              ON CONFLICT DO UPDATE SET
                hearizons_id = excluded.hearizons_id,
                phase_id = excluded.phase_id,
                user_id = excluded.user_id,
                url = excluded.url
              RETURNING id;
            ''',
            [submission.hearizonsId, submission.phaseId, submission.userId, submission.url],
          )
          .first
          .values
          .first;

      _submissionCache[id] = submission.copyWith(id: id);
    } else {
      database.execute('''
        UPDATE submissions SET
          hearizons_id = ?,
          phase_id = ?,
          user_id = ?,
          url = ?
        WHERE id = ?;
      ''', [
        submission.hearizonsId,
        submission.phaseId,
        submission.userId,
        submission.url,
        submission.id
      ]);

      _submissionCache[submission.id!] = submission;
    }
  }

  Review _upsertReview(Review review) {
    if (review.id == null) {
      int id = database
          .select(
            '''
              INSERT INTO reviews (submission_id, user_id, content)
              VALUES (?, ?, ?)
              RETURNING id;
            ''',
            [review.submissionId, review.userId, review.content],
          )
          .first
          .values
          .first;

      return _reviewCache[id] = review.copyWith(id: id);
    } else {
      database.execute('''
        UPDATE reviews SET
          submission_id = ?,
          user_id = ?,
          content = ?
        WHERE id = ?;
      ''', [review.submissionId, review.userId, review.content, review.id]);

      return _reviewCache[review.id!] = review;
    }
  }

  void upsertAssignedReviewer(AssignedReviewer assignedReviewer) {
    if (assignedReviewer.id == null) {
      int id = database
          .select(
            '''
              INSERT INTO assigned_reviewers (submission_id, user_id, review_id)
              VALUES (?, ?, ?)
              RETURNING id;
            ''',
            [assignedReviewer.submissionId, assignedReviewer.userId, assignedReviewer.reviewId],
          )
          .first
          .values
          .first;

      _assignedReviewerCache[id] = assignedReviewer.copyWith(id: id);
    } else {
      database.execute('''
        UPDATE assigned_reviewers SET
          submission_id = ?,
          user_id = ?,
          review_id = ?
        WHERE id = ?;
      ''', [
        assignedReviewer.submissionId,
        assignedReviewer.userId,
        assignedReviewer.reviewId,
        assignedReviewer.id
      ]);

      _assignedReviewerCache[assignedReviewer.id!] = assignedReviewer;
    }
  }

  bool hearizonsExists(String name) => hearizons.any((element) => element.name == name);

  bool hasExistingSubmission(Submission submission) => submissions.any(
        (element) =>
            element.hearizonsId == submission.hearizonsId &&
            element.phaseId == submission.phaseId &&
            element.userId == submission.userId,
      );

  Iterable<Submission> getSubmissionsForHearizons(Hearizons hearizons) => submissions.where(
        (submission) =>
            submission.hearizonsId == hearizons.id && submission.phaseId == hearizons.phase,
      );

  AssignedReviewer? getAssignment(int userId, Hearizons hearizons) {
    final reviews = assignedReviewers.where(
      (element) =>
          element.userId == userId &&
          getSubmission(element.submissionId).hearizonsId == hearizons.id &&
          (getSubmission(element.submissionId).phaseId == hearizons.phase ||
              element.reviewId == null),
    );

    if (reviews.isEmpty) {
      return null;
    }

    return reviews.single;
  }

  void submitReview(Review review) {
    review = _upsertReview(review);

    final assignment =
        getAssignment(review.userId, getHearizons(getSubmission(review.submissionId).hearizonsId))!;

    upsertAssignedReviewer(assignment.copyWith(reviewId: review.id));
  }
}
