import 'package:intl/intl.dart';

import '../../domain/entities/usageHistory_entity.dart';
import '../../domain/repositories/usageHistory_repository.dart';
import '../datasources/usageHistory_remote_datasource.dart';

class UsageHistoryRepositoryImpl implements UsageHistoryRepository {
  final UsageHistoryDataSource remoteDataSource;

  UsageHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UsageHistoryEntity>> getUsageHistory() async {
    try {
      final models = await remoteDataSource.getUsageHistory();
      
      // Date formatter for Buddhist calendar (last 2 digits)
      final dateFormat = DateFormat('dd/MM/yy');

      return models.map((model) {
        // Map status string to enum
        UsageHistoryStatus status;
        switch (model.status) {
          case 'paid':
            status = UsageHistoryStatus.completed;
            break;
          case 'unpaid':
          case 'overdue':
          default:
            status = UsageHistoryStatus.pending;
        }

        return UsageHistoryEntity(
          id: model.id,
          billingMonth: model.billingMonth,
          meterReadDate: model.meterReadDate != null 
              ? dateFormat.format(DateTime(model.meterReadDate!.year + 543, model.meterReadDate!.month, model.meterReadDate!.day))
              : '-',
          usageUnit: model.usageUnit,
          paymentDate: model.paymentDate != null 
              ? dateFormat.format(DateTime(model.paymentDate!.year + 543, model.paymentDate!.month, model.paymentDate!.day))
              : '-',
          amount: model.amount,
          status: status,
          type: model.type,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get usage history: $e');
    }
  }
}
