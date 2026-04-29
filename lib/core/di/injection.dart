import 'package:get_it/get_it.dart';

import '../../features/contract/data/datasources/contract_remote_datasource.dart';
import '../../features/contract/data/repositories/contract_repository_impl.dart';
import '../../features/contract/domain/repositories/contract_repository.dart';
import '../../features/contract/domain/usecases/get_contracts_usecase.dart';

import '../../features/appointment/data/datasources/appointment_remote_datasource.dart';
import '../../features/appointment/data/repositories/appointment_repository_impl.dart';
import '../../features/appointment/domain/repositories/appointment_repository.dart';
import '../../features/appointment/domain/usecases/get_appointment_usecase.dart';

import '../../features/communication/data/datasources/communication_remote_datasource.dart';
import '../../features/communication/data/repositories/communication_repository_impl.dart';
import '../../features/communication/domain/repositories/communication_repository.dart';
import '../../features/communication/domain/usecases/get_messages_usecase.dart';
import '../../features/communication/domain/usecases/send_message_usecase.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // UseCases
  sl.registerLazySingleton(() => GetContractsUseCase(sl()));
  sl.registerLazySingleton(() => GetAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ContractRepository>(
    () => ContractRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CommunicationRepository>(
    () => CommunicationRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ContractRemoteDataSource>(
    () => ContractRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CommunicationRemoteDataSource>(
    () => CommunicationRemoteDataSourceImpl(),
  );
}
