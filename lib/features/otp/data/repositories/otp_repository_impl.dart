import '../../domain/entities/otp_entity.dart';
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_remote_datasource.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource remoteDataSource;

  OtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<OtpEntity> requestOtp({required String empId}) async {
    try {
      final result = await remoteDataSource.requestOtp(empId: empId);
      return result;
    } catch (e) {
      throw Exception('Failed to request OTP: $e');
    }
  }

  @override
  Future<bool> verifyOtp({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  }) async {
    try {
      final result = await remoteDataSource.verifyOtp(
        empId: empId,
        otpValue: otpValue,
        codeReference: codeReference,
        token: token,
      );
      return result;
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
