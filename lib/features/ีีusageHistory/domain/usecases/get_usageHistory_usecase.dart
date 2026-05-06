
import '../entities/usageHistory_entity.dart';
import '../repositories/usageHistory_repository.dart';

class UsageHistoryUseCase {
  final UsageHistoryRepository repository;

  UsageHistoryUseCase(this.repository);

  Future<List<UsageHistoryEntity>> execute() {
    return repository.getUsageHistory();
  }
}
