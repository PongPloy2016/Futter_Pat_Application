import '../entities/otp_entity.dart';
import '../repositories/otp_repository.dart';

class RequestOtpUseCase {
  final OtpRepository repository;

  RequestOtpUseCase(this.repository);

  Future<OtpEntity> execute({required String empId}) {
    return repository.requestOtp(empId: empId);
  }
}
