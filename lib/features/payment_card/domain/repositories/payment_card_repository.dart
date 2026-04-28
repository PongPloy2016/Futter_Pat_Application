import '../entities/payment_card_entity.dart';

abstract class PaymentCardRepository {
  Future<PaymentCardEntity> getPaymentCardDetails();
}
