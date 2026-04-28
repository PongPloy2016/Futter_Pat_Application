import '../entities/payment_card_entity.dart';
import '../repositories/payment_card_repository.dart';

class GetPaymentCardUseCase {
  final PaymentCardRepository repository;

  GetPaymentCardUseCase(this.repository);

  Future<PaymentCardEntity> execute() {
    return repository.getPaymentCardDetails();
  }
}
