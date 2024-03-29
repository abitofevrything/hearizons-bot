// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class EventData extends DataClass implements Insertable<EventData> {
  /// The id of the event.
  final int id;

  /// The name of the event.
  final String name;

  /// Whether the event is active.
  final bool active;

  /// The type of event.
  final EventType type;

  /// The length of one cycle's submission phase.
  final Duration submissionsLength;

  /// The length of one cycle's review phase.
  final Duration reviewLength;

  /// The length of one cycle's interval
  final Duration intervalLength;

  /// The id of the channel to send announcements to.
  final Snowflake announcementsChannelId;

  /// The id of the channel to send reviews to.
  final Snowflake reviewsChannelId;

  /// The id of the role to give participants.
  final Snowflake participantRoleId;

  /// The id of the role to mention in announcements.
  final Snowflake announcementRoleId;

  /// The id of the guild in which this event occurs.
  final Snowflake guildId;
  const EventData(
      {required this.id,
      required this.name,
      required this.active,
      required this.type,
      required this.submissionsLength,
      required this.reviewLength,
      required this.intervalLength,
      required this.announcementsChannelId,
      required this.reviewsChannelId,
      required this.participantRoleId,
      required this.announcementRoleId,
      required this.guildId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['active'] = Variable<bool>(active);
    {
      final converter = $EventsTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    {
      final converter = $EventsTable.$convertersubmissionsLength;
      map['submissions_length'] =
          Variable<int>(converter.toSql(submissionsLength));
    }
    {
      final converter = $EventsTable.$converterreviewLength;
      map['review_length'] = Variable<int>(converter.toSql(reviewLength));
    }
    {
      final converter = $EventsTable.$converterintervalLength;
      map['interval_length'] = Variable<int>(converter.toSql(intervalLength));
    }
    {
      final converter = $EventsTable.$converterannouncementsChannelId;
      map['announcements_channel_id'] =
          Variable<BigInt>(converter.toSql(announcementsChannelId));
    }
    {
      final converter = $EventsTable.$converterreviewsChannelId;
      map['reviews_channel_id'] =
          Variable<BigInt>(converter.toSql(reviewsChannelId));
    }
    {
      final converter = $EventsTable.$converterparticipantRoleId;
      map['participant_role_id'] =
          Variable<BigInt>(converter.toSql(participantRoleId));
    }
    {
      final converter = $EventsTable.$converterannouncementRoleId;
      map['announcement_role_id'] =
          Variable<BigInt>(converter.toSql(announcementRoleId));
    }
    {
      final converter = $EventsTable.$converterguildId;
      map['guild_id'] = Variable<BigInt>(converter.toSql(guildId));
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      name: Value(name),
      active: Value(active),
      type: Value(type),
      submissionsLength: Value(submissionsLength),
      reviewLength: Value(reviewLength),
      intervalLength: Value(intervalLength),
      announcementsChannelId: Value(announcementsChannelId),
      reviewsChannelId: Value(reviewsChannelId),
      participantRoleId: Value(participantRoleId),
      announcementRoleId: Value(announcementRoleId),
      guildId: Value(guildId),
    );
  }

  factory EventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
      type: $EventsTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      submissionsLength:
          serializer.fromJson<Duration>(json['submissionsLength']),
      reviewLength: serializer.fromJson<Duration>(json['reviewLength']),
      intervalLength: serializer.fromJson<Duration>(json['intervalLength']),
      announcementsChannelId:
          serializer.fromJson<Snowflake>(json['announcementsChannelId']),
      reviewsChannelId:
          serializer.fromJson<Snowflake>(json['reviewsChannelId']),
      participantRoleId:
          serializer.fromJson<Snowflake>(json['participantRoleId']),
      announcementRoleId:
          serializer.fromJson<Snowflake>(json['announcementRoleId']),
      guildId: serializer.fromJson<Snowflake>(json['guildId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
      'type': serializer.toJson<int>($EventsTable.$convertertype.toJson(type)),
      'submissionsLength': serializer.toJson<Duration>(submissionsLength),
      'reviewLength': serializer.toJson<Duration>(reviewLength),
      'intervalLength': serializer.toJson<Duration>(intervalLength),
      'announcementsChannelId':
          serializer.toJson<Snowflake>(announcementsChannelId),
      'reviewsChannelId': serializer.toJson<Snowflake>(reviewsChannelId),
      'participantRoleId': serializer.toJson<Snowflake>(participantRoleId),
      'announcementRoleId': serializer.toJson<Snowflake>(announcementRoleId),
      'guildId': serializer.toJson<Snowflake>(guildId),
    };
  }

  EventData copyWith(
          {int? id,
          String? name,
          bool? active,
          EventType? type,
          Duration? submissionsLength,
          Duration? reviewLength,
          Duration? intervalLength,
          Snowflake? announcementsChannelId,
          Snowflake? reviewsChannelId,
          Snowflake? participantRoleId,
          Snowflake? announcementRoleId,
          Snowflake? guildId}) =>
      EventData(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
        type: type ?? this.type,
        submissionsLength: submissionsLength ?? this.submissionsLength,
        reviewLength: reviewLength ?? this.reviewLength,
        intervalLength: intervalLength ?? this.intervalLength,
        announcementsChannelId:
            announcementsChannelId ?? this.announcementsChannelId,
        reviewsChannelId: reviewsChannelId ?? this.reviewsChannelId,
        participantRoleId: participantRoleId ?? this.participantRoleId,
        announcementRoleId: announcementRoleId ?? this.announcementRoleId,
        guildId: guildId ?? this.guildId,
      );
  @override
  String toString() {
    return (StringBuffer('EventData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('type: $type, ')
          ..write('submissionsLength: $submissionsLength, ')
          ..write('reviewLength: $reviewLength, ')
          ..write('intervalLength: $intervalLength, ')
          ..write('announcementsChannelId: $announcementsChannelId, ')
          ..write('reviewsChannelId: $reviewsChannelId, ')
          ..write('participantRoleId: $participantRoleId, ')
          ..write('announcementRoleId: $announcementRoleId, ')
          ..write('guildId: $guildId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      active,
      type,
      submissionsLength,
      reviewLength,
      intervalLength,
      announcementsChannelId,
      reviewsChannelId,
      participantRoleId,
      announcementRoleId,
      guildId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventData &&
          other.id == this.id &&
          other.name == this.name &&
          other.active == this.active &&
          other.type == this.type &&
          other.submissionsLength == this.submissionsLength &&
          other.reviewLength == this.reviewLength &&
          other.intervalLength == this.intervalLength &&
          other.announcementsChannelId == this.announcementsChannelId &&
          other.reviewsChannelId == this.reviewsChannelId &&
          other.participantRoleId == this.participantRoleId &&
          other.announcementRoleId == this.announcementRoleId &&
          other.guildId == this.guildId);
}

class EventsCompanion extends UpdateCompanion<EventData> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> active;
  final Value<EventType> type;
  final Value<Duration> submissionsLength;
  final Value<Duration> reviewLength;
  final Value<Duration> intervalLength;
  final Value<Snowflake> announcementsChannelId;
  final Value<Snowflake> reviewsChannelId;
  final Value<Snowflake> participantRoleId;
  final Value<Snowflake> announcementRoleId;
  final Value<Snowflake> guildId;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
    this.type = const Value.absent(),
    this.submissionsLength = const Value.absent(),
    this.reviewLength = const Value.absent(),
    this.intervalLength = const Value.absent(),
    this.announcementsChannelId = const Value.absent(),
    this.reviewsChannelId = const Value.absent(),
    this.participantRoleId = const Value.absent(),
    this.announcementRoleId = const Value.absent(),
    this.guildId = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required bool active,
    required EventType type,
    required Duration submissionsLength,
    required Duration reviewLength,
    required Duration intervalLength,
    required Snowflake announcementsChannelId,
    required Snowflake reviewsChannelId,
    required Snowflake participantRoleId,
    required Snowflake announcementRoleId,
    required Snowflake guildId,
  })  : name = Value(name),
        active = Value(active),
        type = Value(type),
        submissionsLength = Value(submissionsLength),
        reviewLength = Value(reviewLength),
        intervalLength = Value(intervalLength),
        announcementsChannelId = Value(announcementsChannelId),
        reviewsChannelId = Value(reviewsChannelId),
        participantRoleId = Value(participantRoleId),
        announcementRoleId = Value(announcementRoleId),
        guildId = Value(guildId);
  static Insertable<EventData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? active,
    Expression<int>? type,
    Expression<int>? submissionsLength,
    Expression<int>? reviewLength,
    Expression<int>? intervalLength,
    Expression<BigInt>? announcementsChannelId,
    Expression<BigInt>? reviewsChannelId,
    Expression<BigInt>? participantRoleId,
    Expression<BigInt>? announcementRoleId,
    Expression<BigInt>? guildId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
      if (type != null) 'type': type,
      if (submissionsLength != null) 'submissions_length': submissionsLength,
      if (reviewLength != null) 'review_length': reviewLength,
      if (intervalLength != null) 'interval_length': intervalLength,
      if (announcementsChannelId != null)
        'announcements_channel_id': announcementsChannelId,
      if (reviewsChannelId != null) 'reviews_channel_id': reviewsChannelId,
      if (participantRoleId != null) 'participant_role_id': participantRoleId,
      if (announcementRoleId != null)
        'announcement_role_id': announcementRoleId,
      if (guildId != null) 'guild_id': guildId,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? active,
      Value<EventType>? type,
      Value<Duration>? submissionsLength,
      Value<Duration>? reviewLength,
      Value<Duration>? intervalLength,
      Value<Snowflake>? announcementsChannelId,
      Value<Snowflake>? reviewsChannelId,
      Value<Snowflake>? participantRoleId,
      Value<Snowflake>? announcementRoleId,
      Value<Snowflake>? guildId}) {
    return EventsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      type: type ?? this.type,
      submissionsLength: submissionsLength ?? this.submissionsLength,
      reviewLength: reviewLength ?? this.reviewLength,
      intervalLength: intervalLength ?? this.intervalLength,
      announcementsChannelId:
          announcementsChannelId ?? this.announcementsChannelId,
      reviewsChannelId: reviewsChannelId ?? this.reviewsChannelId,
      participantRoleId: participantRoleId ?? this.participantRoleId,
      announcementRoleId: announcementRoleId ?? this.announcementRoleId,
      guildId: guildId ?? this.guildId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (type.present) {
      final converter = $EventsTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (submissionsLength.present) {
      final converter = $EventsTable.$convertersubmissionsLength;
      map['submissions_length'] =
          Variable<int>(converter.toSql(submissionsLength.value));
    }
    if (reviewLength.present) {
      final converter = $EventsTable.$converterreviewLength;
      map['review_length'] = Variable<int>(converter.toSql(reviewLength.value));
    }
    if (intervalLength.present) {
      final converter = $EventsTable.$converterintervalLength;
      map['interval_length'] =
          Variable<int>(converter.toSql(intervalLength.value));
    }
    if (announcementsChannelId.present) {
      final converter = $EventsTable.$converterannouncementsChannelId;
      map['announcements_channel_id'] =
          Variable<BigInt>(converter.toSql(announcementsChannelId.value));
    }
    if (reviewsChannelId.present) {
      final converter = $EventsTable.$converterreviewsChannelId;
      map['reviews_channel_id'] =
          Variable<BigInt>(converter.toSql(reviewsChannelId.value));
    }
    if (participantRoleId.present) {
      final converter = $EventsTable.$converterparticipantRoleId;
      map['participant_role_id'] =
          Variable<BigInt>(converter.toSql(participantRoleId.value));
    }
    if (announcementRoleId.present) {
      final converter = $EventsTable.$converterannouncementRoleId;
      map['announcement_role_id'] =
          Variable<BigInt>(converter.toSql(announcementRoleId.value));
    }
    if (guildId.present) {
      final converter = $EventsTable.$converterguildId;
      map['guild_id'] = Variable<BigInt>(converter.toSql(guildId.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('type: $type, ')
          ..write('submissionsLength: $submissionsLength, ')
          ..write('reviewLength: $reviewLength, ')
          ..write('intervalLength: $intervalLength, ')
          ..write('announcementsChannelId: $announcementsChannelId, ')
          ..write('reviewsChannelId: $reviewsChannelId, ')
          ..write('participantRoleId: $participantRoleId, ')
          ..write('announcementRoleId: $announcementRoleId, ')
          ..write('guildId: $guildId')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, EventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active =
      GeneratedColumn<bool>('active', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<EventType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<EventType>($EventsTable.$convertertype);
  static const VerificationMeta _submissionsLengthMeta =
      const VerificationMeta('submissionsLength');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> submissionsLength =
      GeneratedColumn<int>('submissions_length', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Duration>($EventsTable.$convertersubmissionsLength);
  static const VerificationMeta _reviewLengthMeta =
      const VerificationMeta('reviewLength');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> reviewLength =
      GeneratedColumn<int>('review_length', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Duration>($EventsTable.$converterreviewLength);
  static const VerificationMeta _intervalLengthMeta =
      const VerificationMeta('intervalLength');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> intervalLength =
      GeneratedColumn<int>('interval_length', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Duration>($EventsTable.$converterintervalLength);
  static const VerificationMeta _announcementsChannelIdMeta =
      const VerificationMeta('announcementsChannelId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      announcementsChannelId = GeneratedColumn<BigInt>(
              'announcements_channel_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>(
              $EventsTable.$converterannouncementsChannelId);
  static const VerificationMeta _reviewsChannelIdMeta =
      const VerificationMeta('reviewsChannelId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      reviewsChannelId = GeneratedColumn<BigInt>(
              'reviews_channel_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($EventsTable.$converterreviewsChannelId);
  static const VerificationMeta _participantRoleIdMeta =
      const VerificationMeta('participantRoleId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      participantRoleId = GeneratedColumn<BigInt>(
              'participant_role_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($EventsTable.$converterparticipantRoleId);
  static const VerificationMeta _announcementRoleIdMeta =
      const VerificationMeta('announcementRoleId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      announcementRoleId = GeneratedColumn<BigInt>(
              'announcement_role_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($EventsTable.$converterannouncementRoleId);
  static const VerificationMeta _guildIdMeta =
      const VerificationMeta('guildId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt> guildId =
      GeneratedColumn<BigInt>('guild_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($EventsTable.$converterguildId);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        active,
        type,
        submissionsLength,
        reviewLength,
        intervalLength,
        announcementsChannelId,
        reviewsChannelId,
        participantRoleId,
        announcementRoleId,
        guildId
      ];
  @override
  String get aliasedName => _alias ?? 'events';
  @override
  String get actualTableName => 'events';
  @override
  VerificationContext validateIntegrity(Insertable<EventData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_submissionsLengthMeta, const VerificationResult.success());
    context.handle(_reviewLengthMeta, const VerificationResult.success());
    context.handle(_intervalLengthMeta, const VerificationResult.success());
    context.handle(
        _announcementsChannelIdMeta, const VerificationResult.success());
    context.handle(_reviewsChannelIdMeta, const VerificationResult.success());
    context.handle(_participantRoleIdMeta, const VerificationResult.success());
    context.handle(_announcementRoleIdMeta, const VerificationResult.success());
    context.handle(_guildIdMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      type: $EventsTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      submissionsLength: $EventsTable.$convertersubmissionsLength.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}submissions_length'])!),
      reviewLength: $EventsTable.$converterreviewLength.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}review_length'])!),
      intervalLength: $EventsTable.$converterintervalLength.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}interval_length'])!),
      announcementsChannelId: $EventsTable.$converterannouncementsChannelId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}announcements_channel_id'])!),
      reviewsChannelId: $EventsTable.$converterreviewsChannelId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}reviews_channel_id'])!),
      participantRoleId: $EventsTable.$converterparticipantRoleId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}participant_role_id'])!),
      announcementRoleId: $EventsTable.$converterannouncementRoleId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}announcement_role_id'])!),
      guildId: $EventsTable.$converterguildId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}guild_id'])!),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EventType, int, int> $convertertype =
      const EnumIndexConverter<EventType>(EventType.values);
  static TypeConverter<Duration, int> $convertersubmissionsLength =
      const DurationConverter();
  static TypeConverter<Duration, int> $converterreviewLength =
      const DurationConverter();
  static TypeConverter<Duration, int> $converterintervalLength =
      const DurationConverter();
  static TypeConverter<Snowflake, BigInt> $converterannouncementsChannelId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterreviewsChannelId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterparticipantRoleId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterannouncementRoleId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterguildId =
      const SnowflakeConverter();
}

class EventDependencie extends DataClass
    implements Insertable<EventDependencie> {
  final int id;

  /// The event for which this dependency is declared.
  final int event;

  /// The depdencency.
  final int dependency;
  const EventDependencie(
      {required this.id, required this.event, required this.dependency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event'] = Variable<int>(event);
    map['dependency'] = Variable<int>(dependency);
    return map;
  }

  EventDependenciesCompanion toCompanion(bool nullToAbsent) {
    return EventDependenciesCompanion(
      id: Value(id),
      event: Value(event),
      dependency: Value(dependency),
    );
  }

  factory EventDependencie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventDependencie(
      id: serializer.fromJson<int>(json['id']),
      event: serializer.fromJson<int>(json['event']),
      dependency: serializer.fromJson<int>(json['dependency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'event': serializer.toJson<int>(event),
      'dependency': serializer.toJson<int>(dependency),
    };
  }

  EventDependencie copyWith({int? id, int? event, int? dependency}) =>
      EventDependencie(
        id: id ?? this.id,
        event: event ?? this.event,
        dependency: dependency ?? this.dependency,
      );
  @override
  String toString() {
    return (StringBuffer('EventDependencie(')
          ..write('id: $id, ')
          ..write('event: $event, ')
          ..write('dependency: $dependency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, event, dependency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventDependencie &&
          other.id == this.id &&
          other.event == this.event &&
          other.dependency == this.dependency);
}

class EventDependenciesCompanion extends UpdateCompanion<EventDependencie> {
  final Value<int> id;
  final Value<int> event;
  final Value<int> dependency;
  const EventDependenciesCompanion({
    this.id = const Value.absent(),
    this.event = const Value.absent(),
    this.dependency = const Value.absent(),
  });
  EventDependenciesCompanion.insert({
    this.id = const Value.absent(),
    required int event,
    required int dependency,
  })  : event = Value(event),
        dependency = Value(dependency);
  static Insertable<EventDependencie> custom({
    Expression<int>? id,
    Expression<int>? event,
    Expression<int>? dependency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (event != null) 'event': event,
      if (dependency != null) 'dependency': dependency,
    });
  }

  EventDependenciesCompanion copyWith(
      {Value<int>? id, Value<int>? event, Value<int>? dependency}) {
    return EventDependenciesCompanion(
      id: id ?? this.id,
      event: event ?? this.event,
      dependency: dependency ?? this.dependency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (event.present) {
      map['event'] = Variable<int>(event.value);
    }
    if (dependency.present) {
      map['dependency'] = Variable<int>(dependency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventDependenciesCompanion(')
          ..write('id: $id, ')
          ..write('event: $event, ')
          ..write('dependency: $dependency')
          ..write(')'))
        .toString();
  }
}

class $EventDependenciesTable extends EventDependencies
    with TableInfo<$EventDependenciesTable, EventDependencie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventDependenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<int> event = GeneratedColumn<int>(
      'event', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  static const VerificationMeta _dependencyMeta =
      const VerificationMeta('dependency');
  @override
  late final GeneratedColumn<int> dependency = GeneratedColumn<int>(
      'dependency', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, event, dependency];
  @override
  String get aliasedName => _alias ?? 'event_dependencies';
  @override
  String get actualTableName => 'event_dependencies';
  @override
  VerificationContext validateIntegrity(Insertable<EventDependencie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event')) {
      context.handle(
          _eventMeta, event.isAcceptableOrUnknown(data['event']!, _eventMeta));
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('dependency')) {
      context.handle(
          _dependencyMeta,
          dependency.isAcceptableOrUnknown(
              data['dependency']!, _dependencyMeta));
    } else if (isInserting) {
      context.missing(_dependencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventDependencie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventDependencie(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      event: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event'])!,
      dependency: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dependency'])!,
    );
  }

  @override
  $EventDependenciesTable createAlias(String alias) {
    return $EventDependenciesTable(attachedDatabase, alias);
  }
}

class Cycle extends DataClass implements Insertable<Cycle> {
  /// The id of the cycle.
  final int id;

  /// The event to which this cycle belongs.
  final int event;

  /// The current status of this cycle.
  final CycleStatus status;

  /// The time at which the current cycle started.
  final DateTime startedAt;

  /// The ID of the guild event representing this cycle's submissions
  final Snowflake submissionsEventId;

  /// The ID of the guild event representing this cycle's reviews
  final Snowflake reviewsEventId;

  /// The ID of the guild event representing the next cycle's submissions
  final Snowflake nextCycleSubmissionsEventId;

  /// The ID of the message in the announcement channel representing the current status.
  final Snowflake statusMessageId;
  const Cycle(
      {required this.id,
      required this.event,
      required this.status,
      required this.startedAt,
      required this.submissionsEventId,
      required this.reviewsEventId,
      required this.nextCycleSubmissionsEventId,
      required this.statusMessageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event'] = Variable<int>(event);
    {
      final converter = $CyclesTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    {
      final converter = $CyclesTable.$convertersubmissionsEventId;
      map['submissions_event_id'] =
          Variable<BigInt>(converter.toSql(submissionsEventId));
    }
    {
      final converter = $CyclesTable.$converterreviewsEventId;
      map['reviews_event_id'] =
          Variable<BigInt>(converter.toSql(reviewsEventId));
    }
    {
      final converter = $CyclesTable.$converternextCycleSubmissionsEventId;
      map['next_cycle_submissions_event_id'] =
          Variable<BigInt>(converter.toSql(nextCycleSubmissionsEventId));
    }
    {
      final converter = $CyclesTable.$converterstatusMessageId;
      map['status_message_id'] =
          Variable<BigInt>(converter.toSql(statusMessageId));
    }
    return map;
  }

  CyclesCompanion toCompanion(bool nullToAbsent) {
    return CyclesCompanion(
      id: Value(id),
      event: Value(event),
      status: Value(status),
      startedAt: Value(startedAt),
      submissionsEventId: Value(submissionsEventId),
      reviewsEventId: Value(reviewsEventId),
      nextCycleSubmissionsEventId: Value(nextCycleSubmissionsEventId),
      statusMessageId: Value(statusMessageId),
    );
  }

  factory Cycle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cycle(
      id: serializer.fromJson<int>(json['id']),
      event: serializer.fromJson<int>(json['event']),
      status: $CyclesTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      submissionsEventId:
          serializer.fromJson<Snowflake>(json['submissionsEventId']),
      reviewsEventId: serializer.fromJson<Snowflake>(json['reviewsEventId']),
      nextCycleSubmissionsEventId:
          serializer.fromJson<Snowflake>(json['nextCycleSubmissionsEventId']),
      statusMessageId: serializer.fromJson<Snowflake>(json['statusMessageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'event': serializer.toJson<int>(event),
      'status':
          serializer.toJson<int>($CyclesTable.$converterstatus.toJson(status)),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'submissionsEventId': serializer.toJson<Snowflake>(submissionsEventId),
      'reviewsEventId': serializer.toJson<Snowflake>(reviewsEventId),
      'nextCycleSubmissionsEventId':
          serializer.toJson<Snowflake>(nextCycleSubmissionsEventId),
      'statusMessageId': serializer.toJson<Snowflake>(statusMessageId),
    };
  }

  Cycle copyWith(
          {int? id,
          int? event,
          CycleStatus? status,
          DateTime? startedAt,
          Snowflake? submissionsEventId,
          Snowflake? reviewsEventId,
          Snowflake? nextCycleSubmissionsEventId,
          Snowflake? statusMessageId}) =>
      Cycle(
        id: id ?? this.id,
        event: event ?? this.event,
        status: status ?? this.status,
        startedAt: startedAt ?? this.startedAt,
        submissionsEventId: submissionsEventId ?? this.submissionsEventId,
        reviewsEventId: reviewsEventId ?? this.reviewsEventId,
        nextCycleSubmissionsEventId:
            nextCycleSubmissionsEventId ?? this.nextCycleSubmissionsEventId,
        statusMessageId: statusMessageId ?? this.statusMessageId,
      );
  @override
  String toString() {
    return (StringBuffer('Cycle(')
          ..write('id: $id, ')
          ..write('event: $event, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('submissionsEventId: $submissionsEventId, ')
          ..write('reviewsEventId: $reviewsEventId, ')
          ..write('nextCycleSubmissionsEventId: $nextCycleSubmissionsEventId, ')
          ..write('statusMessageId: $statusMessageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      event,
      status,
      startedAt,
      submissionsEventId,
      reviewsEventId,
      nextCycleSubmissionsEventId,
      statusMessageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cycle &&
          other.id == this.id &&
          other.event == this.event &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.submissionsEventId == this.submissionsEventId &&
          other.reviewsEventId == this.reviewsEventId &&
          other.nextCycleSubmissionsEventId ==
              this.nextCycleSubmissionsEventId &&
          other.statusMessageId == this.statusMessageId);
}

class CyclesCompanion extends UpdateCompanion<Cycle> {
  final Value<int> id;
  final Value<int> event;
  final Value<CycleStatus> status;
  final Value<DateTime> startedAt;
  final Value<Snowflake> submissionsEventId;
  final Value<Snowflake> reviewsEventId;
  final Value<Snowflake> nextCycleSubmissionsEventId;
  final Value<Snowflake> statusMessageId;
  const CyclesCompanion({
    this.id = const Value.absent(),
    this.event = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.submissionsEventId = const Value.absent(),
    this.reviewsEventId = const Value.absent(),
    this.nextCycleSubmissionsEventId = const Value.absent(),
    this.statusMessageId = const Value.absent(),
  });
  CyclesCompanion.insert({
    this.id = const Value.absent(),
    required int event,
    required CycleStatus status,
    required DateTime startedAt,
    required Snowflake submissionsEventId,
    required Snowflake reviewsEventId,
    required Snowflake nextCycleSubmissionsEventId,
    required Snowflake statusMessageId,
  })  : event = Value(event),
        status = Value(status),
        startedAt = Value(startedAt),
        submissionsEventId = Value(submissionsEventId),
        reviewsEventId = Value(reviewsEventId),
        nextCycleSubmissionsEventId = Value(nextCycleSubmissionsEventId),
        statusMessageId = Value(statusMessageId);
  static Insertable<Cycle> custom({
    Expression<int>? id,
    Expression<int>? event,
    Expression<int>? status,
    Expression<DateTime>? startedAt,
    Expression<BigInt>? submissionsEventId,
    Expression<BigInt>? reviewsEventId,
    Expression<BigInt>? nextCycleSubmissionsEventId,
    Expression<BigInt>? statusMessageId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (event != null) 'event': event,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (submissionsEventId != null)
        'submissions_event_id': submissionsEventId,
      if (reviewsEventId != null) 'reviews_event_id': reviewsEventId,
      if (nextCycleSubmissionsEventId != null)
        'next_cycle_submissions_event_id': nextCycleSubmissionsEventId,
      if (statusMessageId != null) 'status_message_id': statusMessageId,
    });
  }

  CyclesCompanion copyWith(
      {Value<int>? id,
      Value<int>? event,
      Value<CycleStatus>? status,
      Value<DateTime>? startedAt,
      Value<Snowflake>? submissionsEventId,
      Value<Snowflake>? reviewsEventId,
      Value<Snowflake>? nextCycleSubmissionsEventId,
      Value<Snowflake>? statusMessageId}) {
    return CyclesCompanion(
      id: id ?? this.id,
      event: event ?? this.event,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      submissionsEventId: submissionsEventId ?? this.submissionsEventId,
      reviewsEventId: reviewsEventId ?? this.reviewsEventId,
      nextCycleSubmissionsEventId:
          nextCycleSubmissionsEventId ?? this.nextCycleSubmissionsEventId,
      statusMessageId: statusMessageId ?? this.statusMessageId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (event.present) {
      map['event'] = Variable<int>(event.value);
    }
    if (status.present) {
      final converter = $CyclesTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (submissionsEventId.present) {
      final converter = $CyclesTable.$convertersubmissionsEventId;
      map['submissions_event_id'] =
          Variable<BigInt>(converter.toSql(submissionsEventId.value));
    }
    if (reviewsEventId.present) {
      final converter = $CyclesTable.$converterreviewsEventId;
      map['reviews_event_id'] =
          Variable<BigInt>(converter.toSql(reviewsEventId.value));
    }
    if (nextCycleSubmissionsEventId.present) {
      final converter = $CyclesTable.$converternextCycleSubmissionsEventId;
      map['next_cycle_submissions_event_id'] =
          Variable<BigInt>(converter.toSql(nextCycleSubmissionsEventId.value));
    }
    if (statusMessageId.present) {
      final converter = $CyclesTable.$converterstatusMessageId;
      map['status_message_id'] =
          Variable<BigInt>(converter.toSql(statusMessageId.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CyclesCompanion(')
          ..write('id: $id, ')
          ..write('event: $event, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('submissionsEventId: $submissionsEventId, ')
          ..write('reviewsEventId: $reviewsEventId, ')
          ..write('nextCycleSubmissionsEventId: $nextCycleSubmissionsEventId, ')
          ..write('statusMessageId: $statusMessageId')
          ..write(')'))
        .toString();
  }
}

class $CyclesTable extends Cycles with TableInfo<$CyclesTable, Cycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<int> event = GeneratedColumn<int>(
      'event', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<CycleStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CycleStatus>($CyclesTable.$converterstatus);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _submissionsEventIdMeta =
      const VerificationMeta('submissionsEventId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      submissionsEventId = GeneratedColumn<BigInt>(
              'submissions_event_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($CyclesTable.$convertersubmissionsEventId);
  static const VerificationMeta _reviewsEventIdMeta =
      const VerificationMeta('reviewsEventId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      reviewsEventId = GeneratedColumn<BigInt>(
              'reviews_event_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($CyclesTable.$converterreviewsEventId);
  static const VerificationMeta _nextCycleSubmissionsEventIdMeta =
      const VerificationMeta('nextCycleSubmissionsEventId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      nextCycleSubmissionsEventId = GeneratedColumn<BigInt>(
              'next_cycle_submissions_event_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>(
              $CyclesTable.$converternextCycleSubmissionsEventId);
  static const VerificationMeta _statusMessageIdMeta =
      const VerificationMeta('statusMessageId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt>
      statusMessageId = GeneratedColumn<BigInt>(
              'status_message_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($CyclesTable.$converterstatusMessageId);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        event,
        status,
        startedAt,
        submissionsEventId,
        reviewsEventId,
        nextCycleSubmissionsEventId,
        statusMessageId
      ];
  @override
  String get aliasedName => _alias ?? 'cycles';
  @override
  String get actualTableName => 'cycles';
  @override
  VerificationContext validateIntegrity(Insertable<Cycle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event')) {
      context.handle(
          _eventMeta, event.isAcceptableOrUnknown(data['event']!, _eventMeta));
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    context.handle(_submissionsEventIdMeta, const VerificationResult.success());
    context.handle(_reviewsEventIdMeta, const VerificationResult.success());
    context.handle(
        _nextCycleSubmissionsEventIdMeta, const VerificationResult.success());
    context.handle(_statusMessageIdMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cycle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      event: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event'])!,
      status: $CyclesTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      submissionsEventId: $CyclesTable.$convertersubmissionsEventId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}submissions_event_id'])!),
      reviewsEventId: $CyclesTable.$converterreviewsEventId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}reviews_event_id'])!),
      nextCycleSubmissionsEventId: $CyclesTable
          .$converternextCycleSubmissionsEventId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}next_cycle_submissions_event_id'])!),
      statusMessageId: $CyclesTable.$converterstatusMessageId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.bigInt,
              data['${effectivePrefix}status_message_id'])!),
    );
  }

  @override
  $CyclesTable createAlias(String alias) {
    return $CyclesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CycleStatus, int, int> $converterstatus =
      const EnumIndexConverter<CycleStatus>(CycleStatus.values);
  static TypeConverter<Snowflake, BigInt> $convertersubmissionsEventId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterreviewsEventId =
      const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt>
      $converternextCycleSubmissionsEventId = const SnowflakeConverter();
  static TypeConverter<Snowflake, BigInt> $converterstatusMessageId =
      const SnowflakeConverter();
}

class CurrentCycle extends DataClass implements Insertable<CurrentCycle> {
  final int event;
  final int cycle;
  const CurrentCycle({required this.event, required this.cycle});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event'] = Variable<int>(event);
    map['cycle'] = Variable<int>(cycle);
    return map;
  }

  CurrentCyclesCompanion toCompanion(bool nullToAbsent) {
    return CurrentCyclesCompanion(
      event: Value(event),
      cycle: Value(cycle),
    );
  }

  factory CurrentCycle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrentCycle(
      event: serializer.fromJson<int>(json['event']),
      cycle: serializer.fromJson<int>(json['cycle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'event': serializer.toJson<int>(event),
      'cycle': serializer.toJson<int>(cycle),
    };
  }

  CurrentCycle copyWith({int? event, int? cycle}) => CurrentCycle(
        event: event ?? this.event,
        cycle: cycle ?? this.cycle,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentCycle(')
          ..write('event: $event, ')
          ..write('cycle: $cycle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(event, cycle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentCycle &&
          other.event == this.event &&
          other.cycle == this.cycle);
}

class CurrentCyclesCompanion extends UpdateCompanion<CurrentCycle> {
  final Value<int> event;
  final Value<int> cycle;
  const CurrentCyclesCompanion({
    this.event = const Value.absent(),
    this.cycle = const Value.absent(),
  });
  CurrentCyclesCompanion.insert({
    required int event,
    required int cycle,
  })  : event = Value(event),
        cycle = Value(cycle);
  static Insertable<CurrentCycle> custom({
    Expression<int>? event,
    Expression<int>? cycle,
  }) {
    return RawValuesInsertable({
      if (event != null) 'event': event,
      if (cycle != null) 'cycle': cycle,
    });
  }

  CurrentCyclesCompanion copyWith({Value<int>? event, Value<int>? cycle}) {
    return CurrentCyclesCompanion(
      event: event ?? this.event,
      cycle: cycle ?? this.cycle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (event.present) {
      map['event'] = Variable<int>(event.value);
    }
    if (cycle.present) {
      map['cycle'] = Variable<int>(cycle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrentCyclesCompanion(')
          ..write('event: $event, ')
          ..write('cycle: $cycle')
          ..write(')'))
        .toString();
  }
}

class $CurrentCyclesTable extends CurrentCycles
    with TableInfo<$CurrentCyclesTable, CurrentCycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrentCyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<int> event = GeneratedColumn<int>(
      'event', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  static const VerificationMeta _cycleMeta = const VerificationMeta('cycle');
  @override
  late final GeneratedColumn<int> cycle = GeneratedColumn<int>(
      'cycle', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cycles (id)'));
  @override
  List<GeneratedColumn> get $columns => [event, cycle];
  @override
  String get aliasedName => _alias ?? 'current_cycles';
  @override
  String get actualTableName => 'current_cycles';
  @override
  VerificationContext validateIntegrity(Insertable<CurrentCycle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event')) {
      context.handle(
          _eventMeta, event.isAcceptableOrUnknown(data['event']!, _eventMeta));
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('cycle')) {
      context.handle(
          _cycleMeta, cycle.isAcceptableOrUnknown(data['cycle']!, _cycleMeta));
    } else if (isInserting) {
      context.missing(_cycleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CurrentCycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrentCycle(
      event: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event'])!,
      cycle: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cycle'])!,
    );
  }

  @override
  $CurrentCyclesTable createAlias(String alias) {
    return $CurrentCyclesTable(attachedDatabase, alias);
  }
}

class Submission extends DataClass implements Insertable<Submission> {
  /// The id of the submission.
  final int id;

  /// The cycle to which this submission belongs.
  final int cycle;

  /// The ID of the user who submitted this content.
  final Snowflake userId;

  /// The content of the submission.
  final String content;

  /// A URL where this submission's content can be found, if any.
  final String? url;

  /// The title of this submission, if any.
  final String? title;

  /// The name of this submission's artist, if any.
  final String? artist;
  const Submission(
      {required this.id,
      required this.cycle,
      required this.userId,
      required this.content,
      this.url,
      this.title,
      this.artist});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cycle'] = Variable<int>(cycle);
    {
      final converter = $SubmissionsTable.$converteruserId;
      map['user_id'] = Variable<BigInt>(converter.toSql(userId));
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    return map;
  }

  SubmissionsCompanion toCompanion(bool nullToAbsent) {
    return SubmissionsCompanion(
      id: Value(id),
      cycle: Value(cycle),
      userId: Value(userId),
      content: Value(content),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
    );
  }

  factory Submission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Submission(
      id: serializer.fromJson<int>(json['id']),
      cycle: serializer.fromJson<int>(json['cycle']),
      userId: serializer.fromJson<Snowflake>(json['userId']),
      content: serializer.fromJson<String>(json['content']),
      url: serializer.fromJson<String?>(json['url']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cycle': serializer.toJson<int>(cycle),
      'userId': serializer.toJson<Snowflake>(userId),
      'content': serializer.toJson<String>(content),
      'url': serializer.toJson<String?>(url),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
    };
  }

  Submission copyWith(
          {int? id,
          int? cycle,
          Snowflake? userId,
          String? content,
          Value<String?> url = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> artist = const Value.absent()}) =>
      Submission(
        id: id ?? this.id,
        cycle: cycle ?? this.cycle,
        userId: userId ?? this.userId,
        content: content ?? this.content,
        url: url.present ? url.value : this.url,
        title: title.present ? title.value : this.title,
        artist: artist.present ? artist.value : this.artist,
      );
  @override
  String toString() {
    return (StringBuffer('Submission(')
          ..write('id: $id, ')
          ..write('cycle: $cycle, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cycle, userId, content, url, title, artist);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Submission &&
          other.id == this.id &&
          other.cycle == this.cycle &&
          other.userId == this.userId &&
          other.content == this.content &&
          other.url == this.url &&
          other.title == this.title &&
          other.artist == this.artist);
}

class SubmissionsCompanion extends UpdateCompanion<Submission> {
  final Value<int> id;
  final Value<int> cycle;
  final Value<Snowflake> userId;
  final Value<String> content;
  final Value<String?> url;
  final Value<String?> title;
  final Value<String?> artist;
  const SubmissionsCompanion({
    this.id = const Value.absent(),
    this.cycle = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
  });
  SubmissionsCompanion.insert({
    this.id = const Value.absent(),
    required int cycle,
    required Snowflake userId,
    required String content,
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
  })  : cycle = Value(cycle),
        userId = Value(userId),
        content = Value(content);
  static Insertable<Submission> custom({
    Expression<int>? id,
    Expression<int>? cycle,
    Expression<BigInt>? userId,
    Expression<String>? content,
    Expression<String>? url,
    Expression<String>? title,
    Expression<String>? artist,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cycle != null) 'cycle': cycle,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
      if (url != null) 'url': url,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
    });
  }

  SubmissionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cycle,
      Value<Snowflake>? userId,
      Value<String>? content,
      Value<String?>? url,
      Value<String?>? title,
      Value<String?>? artist}) {
    return SubmissionsCompanion(
      id: id ?? this.id,
      cycle: cycle ?? this.cycle,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      url: url ?? this.url,
      title: title ?? this.title,
      artist: artist ?? this.artist,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cycle.present) {
      map['cycle'] = Variable<int>(cycle.value);
    }
    if (userId.present) {
      final converter = $SubmissionsTable.$converteruserId;
      map['user_id'] = Variable<BigInt>(converter.toSql(userId.value));
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubmissionsCompanion(')
          ..write('id: $id, ')
          ..write('cycle: $cycle, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }
}

class $SubmissionsTable extends Submissions
    with TableInfo<$SubmissionsTable, Submission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubmissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cycleMeta = const VerificationMeta('cycle');
  @override
  late final GeneratedColumn<int> cycle = GeneratedColumn<int>(
      'cycle', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cycles (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt> userId =
      GeneratedColumn<BigInt>('user_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($SubmissionsTable.$converteruserId);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cycle, userId, content, url, title, artist];
  @override
  String get aliasedName => _alias ?? 'submissions';
  @override
  String get actualTableName => 'submissions';
  @override
  VerificationContext validateIntegrity(Insertable<Submission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cycle')) {
      context.handle(
          _cycleMeta, cycle.isAcceptableOrUnknown(data['cycle']!, _cycleMeta));
    } else if (isInserting) {
      context.missing(_cycleMeta);
    }
    context.handle(_userIdMeta, const VerificationResult.success());
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Submission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Submission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cycle: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cycle'])!,
      userId: $SubmissionsTable.$converteruserId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist']),
    );
  }

  @override
  $SubmissionsTable createAlias(String alias) {
    return $SubmissionsTable(attachedDatabase, alias);
  }

  static TypeConverter<Snowflake, BigInt> $converteruserId =
      const SnowflakeConverter();
}

class Assignment extends DataClass implements Insertable<Assignment> {
  /// The id of the assignment.
  final int id;

  /// The submission to review.
  final int submission;

  /// The user who should perform the review.
  final Snowflake assignedUser;

  /// Whether this assignment was discarded despite not being completed.
  final bool discarded;
  const Assignment(
      {required this.id,
      required this.submission,
      required this.assignedUser,
      required this.discarded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['submission'] = Variable<int>(submission);
    {
      final converter = $AssignmentsTable.$converterassignedUser;
      map['assigned_user'] = Variable<BigInt>(converter.toSql(assignedUser));
    }
    map['discarded'] = Variable<bool>(discarded);
    return map;
  }

  AssignmentsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentsCompanion(
      id: Value(id),
      submission: Value(submission),
      assignedUser: Value(assignedUser),
      discarded: Value(discarded),
    );
  }

  factory Assignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assignment(
      id: serializer.fromJson<int>(json['id']),
      submission: serializer.fromJson<int>(json['submission']),
      assignedUser: serializer.fromJson<Snowflake>(json['assignedUser']),
      discarded: serializer.fromJson<bool>(json['discarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'submission': serializer.toJson<int>(submission),
      'assignedUser': serializer.toJson<Snowflake>(assignedUser),
      'discarded': serializer.toJson<bool>(discarded),
    };
  }

  Assignment copyWith(
          {int? id,
          int? submission,
          Snowflake? assignedUser,
          bool? discarded}) =>
      Assignment(
        id: id ?? this.id,
        submission: submission ?? this.submission,
        assignedUser: assignedUser ?? this.assignedUser,
        discarded: discarded ?? this.discarded,
      );
  @override
  String toString() {
    return (StringBuffer('Assignment(')
          ..write('id: $id, ')
          ..write('submission: $submission, ')
          ..write('assignedUser: $assignedUser, ')
          ..write('discarded: $discarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, submission, assignedUser, discarded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assignment &&
          other.id == this.id &&
          other.submission == this.submission &&
          other.assignedUser == this.assignedUser &&
          other.discarded == this.discarded);
}

class AssignmentsCompanion extends UpdateCompanion<Assignment> {
  final Value<int> id;
  final Value<int> submission;
  final Value<Snowflake> assignedUser;
  final Value<bool> discarded;
  const AssignmentsCompanion({
    this.id = const Value.absent(),
    this.submission = const Value.absent(),
    this.assignedUser = const Value.absent(),
    this.discarded = const Value.absent(),
  });
  AssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int submission,
    required Snowflake assignedUser,
    this.discarded = const Value.absent(),
  })  : submission = Value(submission),
        assignedUser = Value(assignedUser);
  static Insertable<Assignment> custom({
    Expression<int>? id,
    Expression<int>? submission,
    Expression<BigInt>? assignedUser,
    Expression<bool>? discarded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (submission != null) 'submission': submission,
      if (assignedUser != null) 'assigned_user': assignedUser,
      if (discarded != null) 'discarded': discarded,
    });
  }

  AssignmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? submission,
      Value<Snowflake>? assignedUser,
      Value<bool>? discarded}) {
    return AssignmentsCompanion(
      id: id ?? this.id,
      submission: submission ?? this.submission,
      assignedUser: assignedUser ?? this.assignedUser,
      discarded: discarded ?? this.discarded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (submission.present) {
      map['submission'] = Variable<int>(submission.value);
    }
    if (assignedUser.present) {
      final converter = $AssignmentsTable.$converterassignedUser;
      map['assigned_user'] =
          Variable<BigInt>(converter.toSql(assignedUser.value));
    }
    if (discarded.present) {
      map['discarded'] = Variable<bool>(discarded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('submission: $submission, ')
          ..write('assignedUser: $assignedUser, ')
          ..write('discarded: $discarded')
          ..write(')'))
        .toString();
  }
}

class $AssignmentsTable extends Assignments
    with TableInfo<$AssignmentsTable, Assignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _submissionMeta =
      const VerificationMeta('submission');
  @override
  late final GeneratedColumn<int> submission = GeneratedColumn<int>(
      'submission', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES submissions (id)'));
  static const VerificationMeta _assignedUserMeta =
      const VerificationMeta('assignedUser');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt> assignedUser =
      GeneratedColumn<BigInt>('assigned_user', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($AssignmentsTable.$converterassignedUser);
  static const VerificationMeta _discardedMeta =
      const VerificationMeta('discarded');
  @override
  late final GeneratedColumn<bool> discarded =
      GeneratedColumn<bool>('discarded', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("discarded" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, submission, assignedUser, discarded];
  @override
  String get aliasedName => _alias ?? 'assignments';
  @override
  String get actualTableName => 'assignments';
  @override
  VerificationContext validateIntegrity(Insertable<Assignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('submission')) {
      context.handle(
          _submissionMeta,
          submission.isAcceptableOrUnknown(
              data['submission']!, _submissionMeta));
    } else if (isInserting) {
      context.missing(_submissionMeta);
    }
    context.handle(_assignedUserMeta, const VerificationResult.success());
    if (data.containsKey('discarded')) {
      context.handle(_discardedMeta,
          discarded.isAcceptableOrUnknown(data['discarded']!, _discardedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      submission: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}submission'])!,
      assignedUser: $AssignmentsTable.$converterassignedUser.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.bigInt, data['${effectivePrefix}assigned_user'])!),
      discarded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}discarded'])!,
    );
  }

  @override
  $AssignmentsTable createAlias(String alias) {
    return $AssignmentsTable(attachedDatabase, alias);
  }

  static TypeConverter<Snowflake, BigInt> $converterassignedUser =
      const SnowflakeConverter();
}

class Review extends DataClass implements Insertable<Review> {
  /// The id of this review.
  final int id;

  /// The submission to which this review belongs.
  final int submission;

  /// The ID of the user who submitted this review.
  final Snowflake userId;

  /// The content of the review.
  final String content;
  const Review(
      {required this.id,
      required this.submission,
      required this.userId,
      required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['submission'] = Variable<int>(submission);
    {
      final converter = $ReviewsTable.$converteruserId;
      map['user_id'] = Variable<BigInt>(converter.toSql(userId));
    }
    map['content'] = Variable<String>(content);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      submission: Value(submission),
      userId: Value(userId),
      content: Value(content),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<int>(json['id']),
      submission: serializer.fromJson<int>(json['submission']),
      userId: serializer.fromJson<Snowflake>(json['userId']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'submission': serializer.toJson<int>(submission),
      'userId': serializer.toJson<Snowflake>(userId),
      'content': serializer.toJson<String>(content),
    };
  }

  Review copyWith(
          {int? id, int? submission, Snowflake? userId, String? content}) =>
      Review(
        id: id ?? this.id,
        submission: submission ?? this.submission,
        userId: userId ?? this.userId,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('submission: $submission, ')
          ..write('userId: $userId, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, submission, userId, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.submission == this.submission &&
          other.userId == this.userId &&
          other.content == this.content);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<int> id;
  final Value<int> submission;
  final Value<Snowflake> userId;
  final Value<String> content;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.submission = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
  });
  ReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int submission,
    required Snowflake userId,
    required String content,
  })  : submission = Value(submission),
        userId = Value(userId),
        content = Value(content);
  static Insertable<Review> custom({
    Expression<int>? id,
    Expression<int>? submission,
    Expression<BigInt>? userId,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (submission != null) 'submission': submission,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
    });
  }

  ReviewsCompanion copyWith(
      {Value<int>? id,
      Value<int>? submission,
      Value<Snowflake>? userId,
      Value<String>? content}) {
    return ReviewsCompanion(
      id: id ?? this.id,
      submission: submission ?? this.submission,
      userId: userId ?? this.userId,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (submission.present) {
      map['submission'] = Variable<int>(submission.value);
    }
    if (userId.present) {
      final converter = $ReviewsTable.$converteruserId;
      map['user_id'] = Variable<BigInt>(converter.toSql(userId.value));
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('submission: $submission, ')
          ..write('userId: $userId, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _submissionMeta =
      const VerificationMeta('submission');
  @override
  late final GeneratedColumn<int> submission = GeneratedColumn<int>(
      'submission', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES submissions (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumnWithTypeConverter<Snowflake, BigInt> userId =
      GeneratedColumn<BigInt>('user_id', aliasedName, false,
              type: DriftSqlType.bigInt, requiredDuringInsert: true)
          .withConverter<Snowflake>($ReviewsTable.$converteruserId);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, submission, userId, content];
  @override
  String get aliasedName => _alias ?? 'reviews';
  @override
  String get actualTableName => 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('submission')) {
      context.handle(
          _submissionMeta,
          submission.isAcceptableOrUnknown(
              data['submission']!, _submissionMeta));
    } else if (isInserting) {
      context.missing(_submissionMeta);
    }
    context.handle(_userIdMeta, const VerificationResult.success());
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      submission: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}submission'])!,
      userId: $ReviewsTable.$converteruserId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }

  static TypeConverter<Snowflake, BigInt> $converteruserId =
      const SnowflakeConverter();
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $EventsTable events = $EventsTable(this);
  late final $EventDependenciesTable eventDependencies =
      $EventDependenciesTable(this);
  late final $CyclesTable cycles = $CyclesTable(this);
  late final $CurrentCyclesTable currentCycles = $CurrentCyclesTable(this);
  late final $SubmissionsTable submissions = $SubmissionsTable(this);
  late final $AssignmentsTable assignments = $AssignmentsTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        events,
        eventDependencies,
        cycles,
        currentCycles,
        submissions,
        assignments,
        reviews
      ];
}
