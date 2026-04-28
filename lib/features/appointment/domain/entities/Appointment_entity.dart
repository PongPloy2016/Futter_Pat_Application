enum AppointmentStatus {
  pending,
  paid,
}

class AppointmentEntity {
  final String contractId;
  final String contractName;
  final String startDate;
  final String endDate;
  final String monthlyRent;
  final String dueDate;
  final AppointmentStatus status;

  const AppointmentEntity({
    required this.contractId,
    required this.contractName,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.dueDate,
    required this.status,
  });
}
