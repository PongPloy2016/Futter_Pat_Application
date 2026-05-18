import '../entities/otp_entity.dart';

abstract class OtpRepository {
  /// ขอ OTP โดยใช้ empId
  Future<OtpEntity> requestOtp({required String empId});

  /// ยืนยัน OTP
  Future<bool> verifyOtp({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  });
}
