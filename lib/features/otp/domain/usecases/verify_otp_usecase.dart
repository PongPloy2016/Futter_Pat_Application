import '../repositories/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> execute({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  }) {
    return repository.verifyOtp(
      empId: empId,
      otpValue: otpValue,
      codeReference: codeReference,
      token: token,
    );
  }
}
