import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hearizons/error_handler.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
// ignore: implementation_imports
import 'package:nyxx_commands/src/mirror_utils/mirror_utils.dart';

Iterable<ChatCommand> _getChatCommands(IContextData context) =>
    GetIt.I.get<CommandsPlugin>().walkCommands().whereType<ChatCommand>();

String _chatCommandToString(ChatCommand command) => command.fullName;

const commandConverter = SimpleConverter(
  provider: _getChatCommands,
  stringify: _chatCommandToString,
);

final sudo = ChatCommand(
  'sudo',
  'Run a command as another user',
  options: CommandOptions(type: CommandType.slashOnly),
  checks: [GuildCheck.id(Snowflake(Platform.environment['SUDO_GUILD_ID']))],
  id('admin-sudo', (
    InteractionChatContext context,
    @Description('The user to run the command as') IUser user,
    @Description('The command to run') @UseConverter(commandConverter) ChatCommand command,
    @Description('The arguments of the command to run') String arguments,
  ) async {
    final argumentsView = StringView(arguments);
    Map<String, String> fakeArguments = {};

    final data = loadFunctionData(command.execute);
    for (final parameter in data.parametersData.skip(1)) {
      String kebabCaseName = convertToKebabCase(parameter.name);

      fakeArguments[kebabCaseName] = argumentsView.getQuotedWord();
    }

    final fakeContext = _ProxyChatContext(
      original: context,
      fakeMember: await context.guild?.fetchMember(user.id),
      fakeUser: user,
      fakeCommand: command,
      fakeArguments: fakeArguments,
    );

    try {
      await command.invoke(fakeContext);
    } on CommandsException catch (e) {
      await handleError(e);
    }
  }),
);

class _ProxyChatContext extends InteractionChatContext {
  final IUser fakeUser;
  final IMember? fakeMember;
  final ChatCommand fakeCommand;
  final Map<String, String> fakeArguments;

  _ProxyChatContext({
    required InteractionChatContext original,
    required this.fakeMember,
    required this.fakeUser,
    required this.fakeCommand,
    required this.fakeArguments,
  }) : super(
          channel: original.channel,
          client: original.client,
          command: fakeCommand,
          commands: original.commands,
          guild: original.guild,
          member: fakeMember,
          user: fakeUser,
          interaction: original.interaction,
          interactionEvent: original.interactionEvent,
          rawArguments: fakeArguments,
        );
}
