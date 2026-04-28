// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationServiceModel _$NotificationServiceModelFromJson(
  Map<String, dynamic> json,
) => NotificationServiceModel(
  isSuccess: json['isSuccess'] as bool,
  message: json['message'] as String,
  data: NotificationServiceData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NotificationServiceModelToJson(
  NotificationServiceModel instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'message': instance.message,
  'data': instance.data,
};

NotificationServiceData _$NotificationServiceDataFromJson(
  Map<String, dynamic> json,
) => NotificationServiceData(
  totalUnreadMessage: (json['totalUnreadMessage'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  count: (json['count'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => NotificationMobile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NotificationServiceDataToJson(
  NotificationServiceData instance,
) => <String, dynamic>{
  'totalUnreadMessage': instance.totalUnreadMessage,
  'total': instance.total,
  'count': instance.count,
  'data': instance.data,
};

NotificationMobile _$NotificationMobileFromJson(Map<String, dynamic> json) =>
    NotificationMobile(
      id: (json['id'] as num?)?.toInt(),
      toUserId: (json['toUserId'] as num?)?.toInt(),
      title: json['title'] as String?,
      context: json['context'] as String?,
      isRead: json['isRead'] as bool?,
      createdDate: json['createdDate'] as String?,
      sentDate: json['sentDate'] as String?,
      effectiveDate: json['effectiveDate'] as String?,
      fromUser: json['fromUser'] as String?,
      notifyType: json['notifyType'] as String?,
      resourceId: (json['resourceId'] as num?)?.toInt(),
      fileCode: json['fileCode'] as String?,
      refLink: json['refLink'] as String?,
    );

Map<String, dynamic> _$NotificationMobileToJson(NotificationMobile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'toUserId': instance.toUserId,
      'title': instance.title,
      'context': instance.context,
      'isRead': instance.isRead,
      'createdDate': instance.createdDate,
      'sentDate': instance.sentDate,
      'effectiveDate': instance.effectiveDate,
      'fromUser': instance.fromUser,
      'notifyType': instance.notifyType,
      'resourceId': instance.resourceId,
      'fileCode': instance.fileCode,
      'refLink': instance.refLink,
    };
