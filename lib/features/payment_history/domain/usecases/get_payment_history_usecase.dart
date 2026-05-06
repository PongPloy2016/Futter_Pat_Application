
import '../entities/payment_history_entity.dart';
import '../repositories/payment_history_repository.dart';

class paymentHistoryStateUseCase {
  final PaymentHistoryRepository repository;

  paymentHistoryStateUseCase(this.repository);

  Future<List<PaymentHistoryEntity>> execute() {
    return repository.getPaymentHistory();
  }
}
