import '../../domain/entities/Appointment_entity.dart';

class LandItemModel extends LandItemEntity {
  const LandItemModel({
    required super.landNo,
    required super.landname,
    required super.area,
    
    super.isSelected = false,
  });

  factory LandItemModel.fromJson(Map<String, dynamic> json) {
    return LandItemModel(
      landNo: json['landNo'] ?? '',
      landname: json['landname'] ?? '',
      area: json['area'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'landNo': landNo,
        'landname': landname,
        'area': area,
        'isSelected': isSelected,
      };
}

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.contractId,
    required super.contractName,
    required super.startDate,
    required super.endDate,
    required super.monthlyRent,
    required super.dueDate,
    required super.status,
    super.landItems = const [],
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
      landItems: (json['landItems'] as List<dynamic>? ?? [])
          .map((item) => LandItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'contractId': contractId,
        'contractName': contractName,
        'startDate': startDate,
        'endDate': endDate,
        'monthlyRent': monthlyRent,
        'dueDate': dueDate,
        'status': status.name,
        'landItems': landItems
            .map((e) => (e as LandItemModel).toJson())
            .toList(),
      };
}
