// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotification {
  String get id;
  String get userId;
  String get title;
  String get message;
  @TimestampConverter()
  DateTime get timestamp;
  NotificationStatus get status;
  NotificationType get type;
  String? get actionUrl;
  Map<String, dynamic>? get data;
  String? get imageUrl;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      _$AppNotificationCopyWithImpl<AppNotification>(
          this as AppNotification, _$identity);

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      message,
      timestamp,
      status,
      type,
      actionUrl,
      const DeepCollectionEquality().hash(data),
      imageUrl);

  @override
  String toString() {
    return 'AppNotification(id: $id, userId: $userId, title: $title, message: $message, timestamp: $timestamp, status: $status, type: $type, actionUrl: $actionUrl, data: $data, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) _then) =
      _$AppNotificationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String message,
      @TimestampConverter() DateTime timestamp,
      NotificationStatus status,
      NotificationType type,
      String? actionUrl,
      Map<String, dynamic>? data,
      String? imageUrl});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? message = null,
    Object? timestamp = null,
    Object? status = null,
    Object? type = null,
    Object? actionUrl = freezed,
    Object? data = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as NotificationStatus,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      actionUrl: freezed == actionUrl
          ? _self.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppNotification implements AppNotification {
  const _AppNotification(
      {required this.id,
      required this.userId,
      required this.title,
      required this.message,
      @TimestampConverter() required this.timestamp,
      this.status = NotificationStatus.unread,
      this.type = NotificationType.system,
      this.actionUrl,
      final Map<String, dynamic>? data,
      this.imageUrl})
      : _data = data;
  factory _AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String message;
  @override
  @TimestampConverter()
  final DateTime timestamp;
  @override
  @JsonKey()
  final NotificationStatus status;
  @override
  @JsonKey()
  final NotificationType type;
  @override
  final String? actionUrl;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? imageUrl;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppNotificationCopyWith<_AppNotification> get copyWith =>
      __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppNotificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      message,
      timestamp,
      status,
      type,
      actionUrl,
      const DeepCollectionEquality().hash(_data),
      imageUrl);

  @override
  String toString() {
    return 'AppNotification(id: $id, userId: $userId, title: $title, message: $message, timestamp: $timestamp, status: $status, type: $type, actionUrl: $actionUrl, data: $data, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(
          _AppNotification value, $Res Function(_AppNotification) _then) =
      __$AppNotificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String message,
      @TimestampConverter() DateTime timestamp,
      NotificationStatus status,
      NotificationType type,
      String? actionUrl,
      Map<String, dynamic>? data,
      String? imageUrl});
}

/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? message = null,
    Object? timestamp = null,
    Object? status = null,
    Object? type = null,
    Object? actionUrl = freezed,
    Object? data = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_AppNotification(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as NotificationStatus,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      actionUrl: freezed == actionUrl
          ? _self.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
