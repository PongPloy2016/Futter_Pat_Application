import '../entities/check_appointment_entity.dart';
import '../repositories/check_appointment_repository.dart';

class GetCheckAppointmentsUseCase {
  final CheckAppointmentRepository repository;

  GetCheckAppointmentsUseCase(this.repository);

  Future<List<CheckAppointmentEntity>> execute() {
    return repository.getCheckAppointments();
  }
}
