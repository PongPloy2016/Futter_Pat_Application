import '../../../appointment/data/models/appointment_reserve_request_model.dart';
import '../../domain/entities/booking_confirm_queue_entity.dart';
import '../models/booking_confirm_queue_model.dart';

abstract class BookingConfirmQueueRemoteDataSource {
  Future<BookingConfirmQueueModel> getBookingConfirmQueue(
      AppointmentReserveRequestModel request);
}

class BookingConfirmQueueRemoteDataSourceImpl
    implements BookingConfirmQueueRemoteDataSource {
  @override
  Future<BookingConfirmQueueModel> getBookingConfirmQueue(
    AppointmentReserveRequestModel request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return BookingConfirmQueueModel(
      bookingId: '210000001',
      queueNumber: '00011',
      timeLabel: request.startTime ?? 'ช่วงเช้า (08:30 - 11:00)',
      customerName: 'นายมานะ ออกน',
      // ใช้ ?. และ ?? เพื่อป้องกัน null
      contractId:
          (request.contractIds != null && request.contractIds!.isNotEmpty)
              ? request.contractIds!.first
              : '-',
      appointmentDate: request.startDate != null
          ? request.startDate!.toIso8601String()
          : DateTime.now().toIso8601String(),
      appointmentTime: request.startTime ?? "",
      appointmentType: request.appointmentType?.contractName ?? "",
      detail: request.appointmentNote ?? "",
      location: "",
      phone: request.phone ?? "-",
      appointmentItems: request.contractIds?.join(", ") ?? "-",
      // แก้ไขส่วนเอกสารให้ดึงจาก title หรือ path แทน file
      documents: (request.attachmentData ?? [])
          .map((e) => BookingDocumentModel(
                fileName: e.title ??
                    (e.path != null ? e.path!.split('/').last : 'เอกสาร'),
                fileSize: 'ไม่ระบุ',
              ))
          .toList(),
    );
  }
}
