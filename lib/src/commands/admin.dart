import 'package:hearizons_bot/src/checks/admin.dart';
import 'package:hearizons_bot/src/commands/admin/cycle.dart';
import 'package:hearizons_bot/src/commands/admin/hearizons.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final admin = ChatGroup(
  'admin',
  'Manage, create and delete ongoing events',
  checks: [adminCheck],
  children: [hearizons, cycle],
);
