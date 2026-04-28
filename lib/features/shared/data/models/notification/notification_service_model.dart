import 'package:json_annotation/json_annotation.dart';

part 'notification_service_model.g.dart';

@JsonSerializable()
class NotificationServiceModel {
  final bool isSuccess;
  final String message;
  final NotificationServiceData data;

  NotificationServiceModel({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory NotificationServiceModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationServiceModelToJson(this);
}

@JsonSerializable()
class NotificationServiceData {
  final int totalUnreadMessage;
  final int total;
  final int count;
  final List<NotificationMobile> data;

  NotificationServiceData({
    required this.totalUnreadMessage,
    required this.total,
    required this.count,
    required this.data,
  });

  factory NotificationServiceData.fromJson(Map<String, dynamic> json) =>
      _$NotificationServiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationServiceDataToJson(this);
}

@JsonSerializable()
class NotificationMobile {
  final int? id;
  final int? toUserId;
  final String? title;
  final String? context;
  final bool? isRead;
  final String? createdDate;
  final String? sentDate;
  final String? effectiveDate;
  final String? fromUser;
  final String? notifyType;
  final int? resourceId;
  final String? fileCode; // Nullable field, can be null
  final String? refLink; // Nullable field, can be null

  NotificationMobile({
    this.id,
    this.toUserId,
    this.title,
    this.context,
    this.isRead,
    this.createdDate,
    this.sentDate,
    this.effectiveDate,
    this.fromUser,
    this.notifyType,
    this.resourceId,
    this.fileCode, // Optional, will be null if not present in JSON
    this.refLink, // Optional, will be null if not present in JSON
  });

  // Generated methods
  factory NotificationMobile.fromJson(Map<String, dynamic> json) =>
      _$NotificationMobileFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMobileToJson(this);
}
