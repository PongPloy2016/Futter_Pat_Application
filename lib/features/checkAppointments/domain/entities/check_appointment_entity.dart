import 'package:equatable/equatable.dart';

enum CheckAppointmentStatus {
  pending,
  completed,
}

class CheckAppointmentEntity extends Equatable {
  final String queueNumber;
  final CheckAppointmentStatus status;
  final String contractNumber;
  final String details;
  final String date;
  final String time;

  const CheckAppointmentEntity({
    required this.queueNumber,
    required this.status,
    required this.contractNumber,
    required this.details,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [
        queueNumber,
        status,
        contractNumber,
        details,
        date,
        time,
      ];
}
