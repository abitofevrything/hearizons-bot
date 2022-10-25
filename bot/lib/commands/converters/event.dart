import 'package:get_it/get_it.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

String _eventToString(Event event) => event.data.name;

Future<Iterable<Event>> _getAcceptingSubmissionEvents(IContextData context) =>
    GetIt.I.get<Database>().getEventsWithOpenSubmissions();

const acceptingSubmissionEventConverter = SimpleConverter(
  provider: _getAcceptingSubmissionEvents,
  stringify: _eventToString,
  sensitivity: 0,
);
