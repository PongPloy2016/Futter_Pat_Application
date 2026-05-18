import '../../domain/entities/appointment_reserve_request_entity.dart';

class AppointmentReserveRequestModel extends AppointmentReserveRequest {
  const AppointmentReserveRequestModel({
    super.branchId,
    super.appointmentType,
    super.startDate,
    super.startTime,
    super.appointmentNote,
    super.phone,
    super.contractIds,
    super.attachmentData,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'appointmentTypeId': appointmentType?.contractId,
      'startDate': startDate?.toIso8601String(),
      'startTime': startTime,
      'appointmentNote': appointmentNote,
      'phone': phone,
      'contractIds': contractIds,
      'attachmentData': attachmentData?.map((e) => {
        'id': e.id,
        'path': e.path,
        'title': e.title,
      }).toList(),
    };
  }

  factory AppointmentReserveRequestModel.fromEntity(AppointmentReserveRequest entity) {
    return AppointmentReserveRequestModel(
      branchId: entity.branchId,
      appointmentType: entity.appointmentType,
      startDate: entity.startDate,
      startTime: entity.startTime,
      appointmentNote: entity.appointmentNote,
      phone: entity.phone,
      contractIds: entity.contractIds,
      attachmentData: entity.attachmentData,
    );
  }
}
