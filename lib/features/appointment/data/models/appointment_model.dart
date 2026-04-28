import '../../domain/entities/Appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.contractId,
    required super.contractName,
    required super.startDate,
    required super.endDate,
    required super.monthlyRent,
    required super.dueDate,
    required super.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      contractId: json['contractId'] ?? '',
      contractName: json['contractName'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      monthlyRent: json['monthlyRent'] ?? '',
      dueDate: json['dueDate'] ?? '',
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['status']}',
        orElse: () => AppointmentStatus.pending,
      ),
    );
  }
}
