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

Future<Iterable<Event>> _getManageableEvents(IContextData context) =>
    GetIt.I.get<Database>().getManageableEvents(context.guild!.id);

const manageableEventConverter = SimpleConverter(
  provider: _getManageableEvents,
  stringify: _eventToString,
);

Future<Iterable<Event>> _getDeactivateableEvents(IContextData context) async =>
    (await _getManageableEvents(context)).where((event) => event.data.active);

const deactivateableEventConverter = SimpleConverter(
  provider: _getDeactivateableEvents,
  stringify: _eventToString,
);

Future<Iterable<Event>> _getActivateableEvents(IContextData context) async =>
    (await _getManageableEvents(context)).where((event) => !event.data.active);

const activateableEventConverter = SimpleConverter(
  provider: _getActivateableEvents,
  stringify: _eventToString,
);
