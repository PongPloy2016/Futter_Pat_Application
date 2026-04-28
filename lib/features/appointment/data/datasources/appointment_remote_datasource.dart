import '../models/appointment_model.dart';
import '../../domain/entities/Appointment_entity.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAppointment();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  @override
  Future<List<AppointmentModel>> getAppointment() async {
    // Mock data for the appointment renewal flow.
    await Future.delayed(const Duration(seconds: 1));
    return const [
      AppointmentModel(
        contractId: '2101/2569',
        contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        contractId: '2102/2569',
        contractName: 'สัญญาเช่าพื้นที่ดิน',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        contractId: '2103/2569',
        contractName: 'สัญญาเช่าพื้นที่คลังสินค้า',
        startDate: '1 มกราคม 2569',
        endDate: '31 ธันวาคม 2570',
        monthlyRent: '15,000',
        dueDate: 'ทุกวันที่ 10 ของเดือน',
        status: AppointmentStatus.paid,
      ),
    ];
  }
}
