import '../../domain/entities/check_appointment_entity.dart';

class CheckAppointmentModel extends CheckAppointmentEntity {
  const CheckAppointmentModel({
    required super.queueNumber,
    required super.status,
    required super.contractNumber,
    required super.details,
    required super.date,
    required super.time,
  });

  factory CheckAppointmentModel.fromJson(Map<String, dynamic> json) {
    return CheckAppointmentModel(
      queueNumber: json['queueNumber'] ?? '',
      status: json['status'] == 'completed'
          ? CheckAppointmentStatus.completed
          : CheckAppointmentStatus.pending,
      contractNumber: json['contractNumber'] ?? '',
      details: json['details'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'queueNumber': queueNumber,
      'status': status == CheckAppointmentStatus.completed
          ? 'completed'
          : 'pending',
      'contractNumber': contractNumber,
      'details': details,
      'date': date,
      'time': time,
    };
  }
}
