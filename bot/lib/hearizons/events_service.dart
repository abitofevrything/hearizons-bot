import 'package:get_it/get_it.dart';
import 'package:hearizons/database/database.dart';
import 'package:logging/logging.dart';

class EventsService {
  Database get database => GetIt.I.get<Database>();

  final Logger logger = Logger('Events.Service');

  EventsService() {
    _loop();
  }

  Future<Never> _loop() async {
    while (true) {
      await Future.wait([
        // Minimum interval
        Future.delayed(const Duration(seconds: 10)),

        // Handlers
        // Run sequentially to avoid race conditions
        handleEventsPendingReviewPhase().then(
          (_) => handleEventsPendingInterval().then(
            (_) => handleEventsPendingNewCycle(),
          ),
        ),
      ]);
    }
  }

  Future<void> handleEventsPendingReviewPhase() async {
    logger.fine('Handling events pending review phases');

    final events = await database.getEventsPendingReviewPhase();

    logger.fine('Got ${events.length} events pending review phases => ${events.join(', ')}');

    await Future.wait(events.map((event) => event.enterReviewPhase()));

    logger.fine('${events.length} events moved to review phases');
  }

  Future<void> handleEventsPendingInterval() async {
    logger.fine('Handling events pending intervals');

    final events = await database.getEventsPendingInterval();

    logger.fine('Got ${events.length} events pending interval => ${events.join(', ')}');

    await Future.wait(events.map((event) => event.startInterval()));

    logger.fine('${events.length} events moved to interval');
  }

  Future<void> handleEventsPendingNewCycle() async {
    logger.fine('Handling events pending new cycles');

    final events = await database.getEventsPendingNewCycle();

    logger.fine('Got ${events.length} events pending new cycles => ${events.join(', ')}');

    await Future.wait(events.map((event) => event.startNewCycle()));

    logger.fine('${events.length} events moved to new cycles');
  }
}
