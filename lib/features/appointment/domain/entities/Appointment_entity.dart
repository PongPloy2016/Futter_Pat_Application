enum AppointmentStatus {
  pending,
  paid,
}

class LandItemEntity {
  final String landNo;
  final String landname;
  final String area;
  final bool isSelected;

  const LandItemEntity({
    required this.landNo,
    required this.landname,
    required this.area,
    this.isSelected = false,
  });
}

class AppointmentEntity {
  final String contractId;
  final String contractName;
  final String startDate;
  final String endDate;
  final String monthlyRent;
  final String dueDate;
  final AppointmentStatus status;
  final List<LandItemEntity> landItems;

  const AppointmentEntity({
    required this.contractId,
    required this.contractName,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.dueDate,
    required this.status,
    this.landItems = const [],
  });
}
