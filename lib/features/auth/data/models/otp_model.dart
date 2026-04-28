import 'package:json_annotation/json_annotation.dart';

part 'otp_model.g.dart';

@JsonSerializable()
class ResponseRequestOTPModel {
  final bool isSuccess;
  final String? message;
  final ResponseRequestOTPDataModel? data;

  ResponseRequestOTPModel({
    required this.isSuccess,
    this.message,
    this.data,
  });

  factory ResponseRequestOTPModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRequestOTPModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRequestOTPModelToJson(this);
}

@JsonSerializable()
class ResponseRequestOTPDataModel {
  String? expireDate;
  String? codeReference;
  String? token;
  bool? isBlocked;
  DateTime? blockTime;

  ResponseRequestOTPDataModel({
    this.expireDate,
    this.codeReference,
    this.token,
    this.isBlocked,
    this.blockTime,
  });

  factory ResponseRequestOTPDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRequestOTPDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRequestOTPDataModelToJson(this);
}
