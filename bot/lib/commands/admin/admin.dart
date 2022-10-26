import 'package:hearizons/commands/admin/event.dart';
import 'package:hearizons/commands/admin/sudo.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final admin = ChatGroup(
  'admin',
  'Administrative commands',
  checks: [
    PermissionsCheck(PermissionsConstants.administrator),
    GuildCheck.all(),
  ],
  options: CommandOptions(
    defaultResponseLevel: ResponseLevel.public,
  ),
  children: [event, sudo],
);
