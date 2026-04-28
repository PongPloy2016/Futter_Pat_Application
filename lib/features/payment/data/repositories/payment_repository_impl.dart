import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaymentEntity> getPaymentDetails(String contractId) async {
    try {
      return await remoteDataSource.getPaymentDetails(contractId);
    } catch (e) {
      throw Exception('Failed to load payment details');
    }
  }
}
