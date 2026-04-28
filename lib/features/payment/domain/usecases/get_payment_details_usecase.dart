import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class GetPaymentDetailsUseCase {
  final PaymentRepository repository;

  GetPaymentDetailsUseCase(this.repository);

  Future<PaymentEntity> execute(String contractId) {
    return repository.getPaymentDetails(contractId);
  }
}
