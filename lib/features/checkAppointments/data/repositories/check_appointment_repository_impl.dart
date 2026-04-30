import '../../domain/entities/check_appointment_entity.dart';
import '../../domain/repositories/check_appointment_repository.dart';
import '../datasources/check_appointment_remote_datasource.dart';

class CheckAppointmentRepositoryImpl implements CheckAppointmentRepository {
  final CheckAppointmentRemoteDataSource remoteDataSource;

  CheckAppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CheckAppointmentEntity>> getCheckAppointments() async {
    try {
      return await remoteDataSource.getCheckAppointments();
    } catch (e) {
      throw Exception('Failed to get appointments: $e');
    }
  }
}
