import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/appointment_remote_datasource.dart';
import '../../data/repositories/appointment_repository_impl.dart';
import '../../domain/entities/Appointment_entity.dart';
import '../../domain/usecases/get_appointment_usecase.dart';

final appointmentContractListProvider =
    FutureProvider<List<AppointmentEntity>>((ref) async {
  final dataSource = AppointmentRemoteDataSourceImpl();
  final repository = AppointmentRepositoryImpl(remoteDataSource: dataSource);
  final useCase = GetAppointmentUseCase(repository);

  final appointments = await useCase.execute();
  return appointments
      .where((appointment) => appointment.status == AppointmentStatus.pending)
      .toList();
});
