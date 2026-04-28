import '../entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<PaymentEntity> getPaymentDetails(String contractId);
}
