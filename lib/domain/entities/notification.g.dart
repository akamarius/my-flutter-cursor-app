// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
      status:
          $enumDecodeNullable(_$NotificationStatusEnumMap, json['status']) ??
              NotificationStatus.unread,
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
          NotificationType.system,
      actionUrl: json['actionUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'status': _$NotificationStatusEnumMap[instance.status]!,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'actionUrl': instance.actionUrl,
      'data': instance.data,
      'imageUrl': instance.imageUrl,
    };

const _$NotificationStatusEnumMap = {
  NotificationStatus.unread: 'unread',
  NotificationStatus.read: 'read',
};

const _$NotificationTypeEnumMap = {
  NotificationType.claim: 'claim',
  NotificationType.system: 'system',
  NotificationType.reminder: 'reminder',
  NotificationType.update: 'update',
};
