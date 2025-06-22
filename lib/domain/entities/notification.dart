import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationStatus {
  @JsonValue('unread')
  unread,
  @JsonValue('read')
  read,
}

enum NotificationType {
  @JsonValue('claim')
  claim,
  @JsonValue('system')
  system,
  @JsonValue('reminder')
  reminder,
  @JsonValue('update')
  update,
}

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    throw Exception('Cannot convert $json to DateTime');
  }

  @override
  dynamic toJson(DateTime dateTime) => dateTime.toIso8601String();
}

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required String title,
    required String message,
    @TimestampConverter() required DateTime timestamp,
    @Default(NotificationStatus.unread) NotificationStatus status,
    @Default(NotificationType.system) NotificationType type,
    String? actionUrl,
    Map<String, dynamic>? data,
    String? imageUrl,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
