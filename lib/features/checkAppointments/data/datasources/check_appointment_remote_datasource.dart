import '../models/check_appointment_model.dart';

abstract class CheckAppointmentRemoteDataSource {
  Future<List<CheckAppointmentModel>> getCheckAppointments();
}

class CheckAppointmentRemoteDataSourceImpl
    implements CheckAppointmentRemoteDataSource {
  @override
  Future<List<CheckAppointmentModel>> getCheckAppointments() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data based on UI design
    final mockJson = [
      {
        'queueNumber': '001',
        'status': 'pending',
        'contractNumber': '2101/2569',
        'details': 'ห้องเลขที่ A-101 แปลง 12',
        'date': 'ศุกร์ที่ 17 เมษายน 2569',
        'time': 'เวลา 08.30 - 09.00 น.',
      },
      {
        'queueNumber': '002',
        'status': 'completed',
        'contractNumber': '2102/2569',
        'details': 'ห้องเลขที่ A-102 แปลง 12',
        'date': 'จันทร์ที่ 20 เมษายน 2568',
        'time': 'เวลา 08.30 - 09.00 น.',
      },
    ];

    return mockJson
        .map((json) => CheckAppointmentModel.fromJson(json))
        .toList();
  }
}
