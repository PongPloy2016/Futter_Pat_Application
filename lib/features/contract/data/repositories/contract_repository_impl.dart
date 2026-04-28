import '../../domain/entities/contract_entity.dart';
import '../../domain/repositories/contract_repository.dart';
import '../datasources/contract_remote_datasource.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractRemoteDataSource remoteDataSource;

  ContractRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ContractEntity>> getContracts() async {
    try {
      final result = await remoteDataSource.getContracts();
      return result;
    } catch (e) {
      throw Exception('Failed to load contracts');
    }
  }
}
