import '../entities/usageHistory_entity.dart';

abstract class UsageHistoryRepository {
  Future<List<UsageHistoryEntity>> getUsageHistory();
}