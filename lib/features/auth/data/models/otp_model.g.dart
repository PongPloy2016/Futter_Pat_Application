// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRequestOTPModel _$ResponseRequestOTPModelFromJson(
  Map<String, dynamic> json,
) => ResponseRequestOTPModel(
  isSuccess: json['isSuccess'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ResponseRequestOTPDataModel.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ResponseRequestOTPModelToJson(
  ResponseRequestOTPModel instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'message': instance.message,
  'data': instance.data,
};

ResponseRequestOTPDataModel _$ResponseRequestOTPDataModelFromJson(
  Map<String, dynamic> json,
) => ResponseRequestOTPDataModel(
  expireDate: json['expireDate'] as String?,
  codeReference: json['codeReference'] as String?,
  token: json['token'] as String?,
  isBlocked: json['isBlocked'] as bool?,
  blockTime: json['blockTime'] == null
      ? null
      : DateTime.parse(json['blockTime'] as String),
);

Map<String, dynamic> _$ResponseRequestOTPDataModelToJson(
  ResponseRequestOTPDataModel instance,
) => <String, dynamic>{
  'expireDate': instance.expireDate,
  'codeReference': instance.codeReference,
  'token': instance.token,
  'isBlocked': instance.isBlocked,
  'blockTime': instance.blockTime?.toIso8601String(),
};
