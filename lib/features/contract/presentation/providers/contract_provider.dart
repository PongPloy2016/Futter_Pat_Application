import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/contract_entity.dart';
import '../../domain/usecases/get_contracts_usecase.dart';

final contractListProvider = FutureProvider<List<ContractEntity>>((ref) {
  final useCase = sl<GetContractsUseCase>();
  return useCase.execute();
});
