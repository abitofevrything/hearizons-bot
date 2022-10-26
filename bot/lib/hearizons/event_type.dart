import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';

enum EventType {
  basic(
    create: Event.new,
    name: 'Basic event',
  );

  final Event Function(EventData) create;

  final String name;

  const EventType({required this.create, required this.name});
}
