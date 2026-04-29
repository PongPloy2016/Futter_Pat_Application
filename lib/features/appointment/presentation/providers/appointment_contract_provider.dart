import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/Appointment_entity.dart';
import '../../domain/usecases/get_appointment_usecase.dart';

final appointmentContractListProvider = FutureProvider<List<AppointmentEntity>>((
  ref,
) async {
  final useCase = sl<GetAppointmentUseCase>();

  final appointments = await useCase.execute();
  return appointments
      // .where((appointment) => appointment.status == AppointmentStatus.pending)
      .toList();
});
