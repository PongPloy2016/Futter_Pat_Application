import '../entities/check_appointment_entity.dart';

abstract class CheckAppointmentRepository {
  Future<List<CheckAppointmentEntity>> getCheckAppointments();
}
