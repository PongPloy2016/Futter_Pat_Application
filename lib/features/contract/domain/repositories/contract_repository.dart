import '../entities/contract_entity.dart';

abstract class ContractRepository {
  Future<List<ContractEntity>> getContracts();
}
