import 'dart:io' as io;

import 'package:drift/drift.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/platforms/platform.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';

final _youtubeUrlPattern = RegExp(r'https:\/\/(www\.youtube\.com\/watch\?v=|youtu\.be\/)([\w-]+)');

final _logger = Logger('Platform.YouTube');

class YouTube extends Platform {
  final YouTubeApi youtube;
  final AuthClient client;

  YouTube(this.client) : youtube = YouTubeApi(client);

  static Future<YouTube> connect() async {
    final accountCredentials = ServiceAccountCredentials(
      io.Platform.environment['YOUTUBE_CLIENT_EMAIL']!,
      ClientId(io.Platform.environment['YOUTUBE_CLIENT_ID']!),
      io.Platform.environment['YOUTUBE_PRIVATE_KEY']!.replaceAll(r'\n', '\n'),
    );

    final client = await clientViaServiceAccount(
      accountCredentials,
      [YouTubeApi.youtubeReadonlyScope],
    );

    return YouTube(client);
  }

  @override
  Future<SubmissionsCompanion?> createSubmission(
    String submissionContent, {
    required Snowflake userId,
    required int cycle,
  }) async {
    final matches = _youtubeUrlPattern.allMatches(submissionContent);

    if (matches.length != 1) {
      // Either no matches or multiple matches, which we can't handle
      return null;
    }

    final match = matches.single;
    final id = match.group(2)!;

    try {
      _logger.fine('Fetching video with id $id');

      final searchResults = await youtube.videos.list(
        ['snippet'],
        id: [id],
      );

      if (searchResults.items?.length != 1) {
        return null;
      }

      final video = searchResults.items!.single;

      return SubmissionsCompanion.insert(
        cycle: cycle,
        userId: userId,
        content: submissionContent,
        url: Value(match.group(0)!),
        title: Value(video.snippet!.title!),
        artist: Value(video.snippet!.channelTitle!),
      );
    } on ApiRequestError catch (e, s) {
      _logger.warning('Error fetching video', e, s);
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    client.close();
  }
}
