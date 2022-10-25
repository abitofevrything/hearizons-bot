import 'package:hearizons/database/database.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('Database.Reviews');

extension ReviewsUtil on Database {
  Future<Review> createReview(ReviewsCompanion review) async {
    _logger.fine('Creating review => $review');

    return into(reviews).insertReturning(review);
  }
}
