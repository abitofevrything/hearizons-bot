import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/platforms/spotify.dart';
import 'package:hearizons/platforms/youtube.dart';
import 'package:nyxx/nyxx.dart';

abstract class Platform {
  FutureOr<SubmissionsCompanion?> createSubmission(
    String submissionContent, {
    required int cycle,
    required Snowflake userId,
  });

  Future<void> dispose();
}

List<Platform> get platforms => [
      GetIt.I.get<Spotify>(),
      GetIt.I.get<YouTube>(),
    ];
