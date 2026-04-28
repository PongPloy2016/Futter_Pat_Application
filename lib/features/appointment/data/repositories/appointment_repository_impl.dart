import '../../domain/entities/Appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_remote_datasource.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSourceImpl remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AppointmentEntity>> getAppointments() async {
    try {
      final result = await remoteDataSource.getAppointment();
      return result;
    } catch (e) {
      throw Exception('Failed to load appointments');
    }
  }
}
