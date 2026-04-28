import '../entities/Appointment_entity.dart';
import '../repositories/appointment_repository.dart';

class GetAppointmentUseCase {
  final AppointmentRepository repository;

  GetAppointmentUseCase(this.repository);

  Future<List<AppointmentEntity>> execute() {
    return repository.getAppointments();
  }
}
