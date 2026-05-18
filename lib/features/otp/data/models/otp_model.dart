import '../../domain/entities/otp_entity.dart';

class OtpModel extends OtpEntity {
  const OtpModel({
    super.expireDate,
    super.codeReference,
    super.token,
    super.isBlocked,
    super.blockTime,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      expireDate: json['expireDate'] as String?,
      codeReference: json['codeReference'] as String?,
      token: json['token'] as String?,
      isBlocked: json['isBlocked'] as bool?,
      blockTime: json['blockTime'] == null
          ? null
          : DateTime.parse(json['blockTime'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'expireDate': expireDate,
        'codeReference': codeReference,
        'token': token,
        'isBlocked': isBlocked,
        'blockTime': blockTime?.toIso8601String(),
      };
}

/// Response wrapper สำหรับ OTP request API
class OtpResponseModel {
  final bool isSuccess;
  final String? message;
  final OtpModel? data;

  const OtpResponseModel({
    required this.isSuccess,
    this.message,
    this.data,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : OtpModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
