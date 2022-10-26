import 'package:hearizons/hearizons/event_type.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

String _eventTypeToString(EventType type) => type.name;

const eventTypeConverter = SimpleConverter.fixed(
  elements: EventType.values,
  stringify: _eventTypeToString,
);
