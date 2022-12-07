import 'dart:io' as io;

import 'package:drift/drift.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/platforms/platform.dart';
import 'package:hearizons/utils/iterable_extension.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:oauth2/oauth2.dart';
import 'package:spotify/spotify.dart';

final _spotifyUrlPattern = RegExp(r'https:\/\/open\.spotify\.com\/track\/(\w+)');

final Logger _logger = Logger('Platform.Spotify');

class Spotify extends Platform {
  SpotifyApi get spotify => _spotify;
  SpotifyApi _spotify;

  Spotify(this._spotify);

  static Future<Spotify> connect() async {
    return Spotify(await _connectApi());
  }

  static Future<SpotifyApi> _connectApi() async {
    final client = await clientCredentialsGrant(
      Uri(scheme: 'https', host: 'accounts.spotify.com', path: '/api/token'),
      io.Platform.environment['SPOTIFY_CLIENT_ID']!,
      io.Platform.environment['SPOTIFY_CLIENT_SECRET']!,
    );

    return SpotifyApi.fromClient(client);
  }

  Future<SpotifyApi>? _refreshingFuture;
  Future<SpotifyApi> _refresh() async {
    if (_refreshingFuture != null) {
      return _refreshingFuture!;
    }

    _refreshingFuture = _connectApi();
    _spotify = await _refreshingFuture!;
    _refreshingFuture = null;

    return spotify;
  }

  @override
  Future<SubmissionsCompanion?> createSubmission(
    String submissionContent, {
    required int cycle,
    required Snowflake userId,
  }) async {
    final matches = _spotifyUrlPattern.allMatches(submissionContent);

    if (matches.length != 1) {
      // Either no matches or multiple matches, which we can't handle
      return null;
    }

    final match = matches.single;
    final id = match.group(1)!;

    try {
      _logger.fine('Fetching track with id $id');

      if ((await spotify.getCredentials()).isExpired) {
        await _refresh();
      }

      final track = await spotify.tracks.get(id);

      return SubmissionsCompanion.insert(
        cycle: cycle,
        userId: userId,
        content: submissionContent,
        url: Value(match.group(0)!),
        title: Value.ofNullable(track.name),
        artist: Value.ofNullable(
          track.artists?.map((artist) => artist.name!).joinLast(', ', ' and '),
        ),
      );
    } on SpotifyException catch (e, s) {
      _logger.warning('Error fetching track $id', e, s);
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    (await spotify.client).close();
  }
}
