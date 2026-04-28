import '../entities/contract_entity.dart';
import '../repositories/contract_repository.dart';

class GetContractsUseCase {
  final ContractRepository repository;

  GetContractsUseCase(this.repository);

  Future<List<ContractEntity>> execute() {
    return repository.getContracts();
  }
}
