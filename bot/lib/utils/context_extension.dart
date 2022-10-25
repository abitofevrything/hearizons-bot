import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final infoColour = DiscordColor.purple;
final successColour = DiscordColor.green;
final warningColour = DiscordColor.yellow;
final errorColour = DiscordColor.red;

extension Utils on IInteractiveContext {
  Future<IMessage> embed({
    required String title,
    String? content,
    Map<String, String>? fields,
    required DiscordColor color,
  }) =>
      respond(MessageBuilder.embed(
        EmbedBuilder()
          ..title = title
          ..description = content
          ..color = color
          ..timestamp = DateTime.now(),
      ));

  Future<IMessage> info({required String title, required String content}) => embed(
        title: title,
        content: content,
        color: infoColour,
      );

  Future<IMessage> success({required String title, required String content}) => embed(
        title: title,
        content: content,
        color: successColour,
      );

  Future<IMessage> warning({required String title, required String content}) => embed(
        title: title,
        content: content,
        color: warningColour,
      );

  Future<IMessage> error({required String title, required String content}) => embed(
        title: title,
        content: content,
        color: errorColour,
      );
}
