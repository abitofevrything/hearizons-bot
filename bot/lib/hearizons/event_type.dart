import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';

enum EventType {
  basic(Event.new);

  final Event Function(EventData) create;

  const EventType(this.create);
}
