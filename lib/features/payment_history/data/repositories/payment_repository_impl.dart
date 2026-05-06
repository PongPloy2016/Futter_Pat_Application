import '../../domain/entities/payment_history_entity.dart';
import '../../domain/repositories/payment_history_repository.dart';
import '../datasources/payment_remote_datasource.dart';
import '../models/payment_history_model.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
  final PaymentHistoryDataSource remoteDataSource;

  PaymentHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PaymentHistoryEntity>> getPaymentHistory() async {
    try {
      final models = await remoteDataSource.getPaymentHistory();
      return models.map((model) => PaymentHistoryEntity(
        id: model.id,
        title: model.title,
        month: model.monthText,
        invoiceNumber: model.documentNo,
        amount: model.amount,
        dueDate: model.dueDate.toIso8601String(),
        status: model.status == PaymentStatus.paid 
            ? PaymentHistoryStatus.completed 
            : PaymentHistoryStatus.pending,
        type: model.type.name,
      )).toList();
    } catch (e) {
      throw Exception('Failed to get payment history: $e');
    }
  }
}
