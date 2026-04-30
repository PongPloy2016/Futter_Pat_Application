import 'package:flutter_pat_application/features/invoice/data/repositories/invoice_repository_impl.dart';
import 'package:flutter_pat_application/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/contract/data/datasources/contract_remote_datasource.dart';
import '../../features/contract/data/repositories/contract_repository_impl.dart';
import '../../features/contract/domain/repositories/contract_repository.dart';
import '../../features/contract/domain/usecases/get_contracts_usecase.dart';
import '../../features/home/domain/usecases/get_home_services_usecase.dart';
import '../../features/home/domain/usecases/get_home_news_usecase.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';

import '../../features/appointment/data/datasources/appointment_remote_datasource.dart';
import '../../features/appointment/data/repositories/appointment_repository_impl.dart';
import '../../features/appointment/domain/repositories/appointment_repository.dart';
import '../../features/appointment/domain/usecases/get_appointment_usecase.dart';

import '../../features/communication/data/datasources/communication_remote_datasource.dart';
import '../../features/communication/data/repositories/communication_repository_impl.dart';
import '../../features/communication/domain/repositories/communication_repository.dart';
import '../../features/communication/domain/usecases/get_messages_usecase.dart';
import '../../features/communication/domain/usecases/send_message_usecase.dart';

import '../../features/attachFileDocuments/data/datasources/attach_file_local_datasource.dart';
import '../../features/attachFileDocuments/data/repositories/attach_file_repository_impl.dart';
import '../../features/attachFileDocuments/domain/repositories/attach_file_repository.dart';
import '../../features/attachFileDocuments/domain/usecases/pick_documents_usecase.dart';

import '../../features/checkAppointments/data/datasources/check_appointment_remote_datasource.dart';
import '../../features/checkAppointments/data/repositories/check_appointment_repository_impl.dart';
import '../../features/checkAppointments/domain/repositories/check_appointment_repository.dart';
import '../../features/checkAppointments/domain/usecases/get_check_appointments_usecase.dart';
import '../../features/invoice/domain/usecases/get_invoice_usecase.dart';
import '../../features/invoice/data/datasources/invoice_remote_datasource.dart';

import '../../features/receipt_tax_invoice/data/datasources/receipt_tax_invoice_remote_datasource.dart';
import '../../features/receipt_tax_invoice/data/repositories/receipt_tax_invoice_repository_impl.dart';
import '../../features/receipt_tax_invoice/domain/repositories/receipt_tax_invoice_repository.dart';
import '../../features/receipt_tax_invoice/domain/usecases/request_receipt_tax_invoice_usecase.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // UseCases
  sl.registerLazySingleton(() => GetContractsUseCase(sl()));
  sl.registerLazySingleton(() => GetAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => PickDocumentsUseCase(sl()));
  sl.registerLazySingleton(() => GetCheckAppointmentsUseCase(sl()));
  sl.registerLazySingleton(() => GetInvoiceUseCase(sl()));
  sl.registerLazySingleton(() => RequestReceiptTaxInvoiceUseCase(sl()));

  // Home Feature
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetHomeServicesUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton(() => GetHomeNewsUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<ContractRepository>(
    () => ContractRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CommunicationRepository>(
    () => CommunicationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AttachFileRepository>(
    () => AttachFileRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CheckAppointmentRepository>(
    () => CheckAppointmentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ReceiptTaxInvoiceRepository>(
    () => ReceiptTaxInvoiceRepositoryImpl(remoteDataSource: sl()),
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
  sl.registerLazySingleton<AttachFileLocalDataSource>(
    () => AttachFileLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<CheckAppointmentRemoteDataSource>(
    () => CheckAppointmentRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ReceiptTaxInvoiceRemoteDataSource>(
    () => ReceiptTaxInvoiceRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<InvoiceRemoteDataSource>(
    () => InvoiceRemoteDataSourceImpl(),
  );
}
