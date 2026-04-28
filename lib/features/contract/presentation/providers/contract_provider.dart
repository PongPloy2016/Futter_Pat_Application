import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/contract_remote_datasource.dart';
import '../../data/repositories/contract_repository_impl.dart';
import '../../domain/entities/contract_entity.dart';
import '../../domain/usecases/get_contracts_usecase.dart';

final contractRemoteDataSourceProvider = Provider<ContractRemoteDataSource>(
  (ref) => ContractRemoteDataSourceImpl(),
);

final contractRepositoryProvider = Provider<ContractRepositoryImpl>((ref) {
  return ContractRepositoryImpl(
    remoteDataSource: ref.watch(contractRemoteDataSourceProvider),
  );
});

final getContractsUseCaseProvider = Provider<GetContractsUseCase>((ref) {
  return GetContractsUseCase(ref.watch(contractRepositoryProvider));
});

final contractListProvider = FutureProvider<List<ContractEntity>>((ref) {
  return ref.watch(getContractsUseCaseProvider).execute();
});
