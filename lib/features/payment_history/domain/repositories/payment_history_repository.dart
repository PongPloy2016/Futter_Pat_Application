import 'package:flutter_pat_application/features/invoice/domain/entities/invoice_entity.dart';

import '../entities/payment_history_entity.dart';

abstract class PaymentHistoryRepository {
  Future<List<PaymentHistoryEntity>> getPaymentHistory();
}