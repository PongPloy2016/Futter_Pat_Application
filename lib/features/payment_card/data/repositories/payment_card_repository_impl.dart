import '../../domain/entities/payment_card_entity.dart';
import '../../domain/repositories/payment_card_repository.dart';
import '../datasources/payment_card_remote_datasource.dart';

class PaymentCardRepositoryImpl implements PaymentCardRepository {
  final PaymentCardRemoteDataSource remoteDataSource;

  PaymentCardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaymentCardEntity> getPaymentCardDetails() async {
    try {
      final result = await remoteDataSource.getPaymentCardDetails();
      return result;
    } catch (e) {
      throw Exception('Failed to load payment card details');
    }
  }
}
