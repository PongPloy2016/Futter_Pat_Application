import '../models/otp_model.dart';

abstract class OtpRemoteDataSource {
  /// เรียก API เพื่อขอ OTP
  Future<OtpModel> requestOtp({required String empId});

  /// เรียก API เพื่อยืนยัน OTP
  Future<bool> verifyOtp({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  });
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  @override
  Future<OtpModel> requestOtp({required String empId}) async {
    // TODO: เชื่อมต่อ API จริง
    // จำลองการเรียก API
    await Future.delayed(const Duration(seconds: 1));

    return OtpModel(
      expireDate: DateTime.now()
          .add(const Duration(minutes: 5))
          .toIso8601String(),
      codeReference: 'REF-${DateTime.now().millisecondsSinceEpoch}',
      token: 'mock-token-$empId',
      isBlocked: false,
      blockTime: null,
    );
  }

  @override
  Future<bool> verifyOtp({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  }) async {
    // TODO: เชื่อมต่อ API จริง
    // จำลองการยืนยัน OTP
    await Future.delayed(const Duration(seconds: 1));

    // Mock: OTP "123456" ถูกต้องเสมอ
    return otpValue.length == 6;
  }
}
