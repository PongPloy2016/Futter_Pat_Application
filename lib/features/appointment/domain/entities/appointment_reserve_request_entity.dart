import 'package:file_picker/file_picker.dart';
import 'Appointment_entity.dart';

class AppointmentReserveRequest {
  final String? branchId;
  final AppointmentEntity? appointmentType;
  final DateTime? startDate;
  final String? startTime;
  final String? appointmentNote;
  final String? phone;
  final List<String>? contractIds;
  final List<AppointmentAttachmentData>? attachmentData;

  const AppointmentReserveRequest({
    this.branchId,
    this.appointmentType,
    this.startDate,
    this.startTime,
    this.appointmentNote,
    this.phone,
    this.contractIds,
    this.attachmentData,
  });
}

class AppointmentAttachmentData {
  final PlatformFile? file;
  final String? id;
  final String? path;
  final String? title;

  const AppointmentAttachmentData({
    this.file,
    this.id,
    this.path,
    this.title,
  });
}
