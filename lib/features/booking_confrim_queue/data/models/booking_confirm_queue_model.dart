import '../../domain/entities/booking_confirm_queue_entity.dart';

class BookingConfirmQueueModel extends BookingConfirmQueueEntity {
  const BookingConfirmQueueModel({
    required super.bookingId,
    required super.queueNumber,
    required super.timeLabel,
    required super.customerName,
    required super.contractId,
    required super.appointmentDate,
    required super.appointmentTime,
    required super.appointmentType,
    required super.detail,
    required super.location,
  });

  factory BookingConfirmQueueModel.mock() {
    return const BookingConfirmQueueModel(
      bookingId: '210000001',
      queueNumber: '001',
      timeLabel: '08.30 น.',
      customerName: 'นายสมใจ ใจดี',
      contractId: '2101/2569',
      appointmentDate: 'วันศุกร์ที่ 17 เมษายน 2569',
      appointmentTime: '08.30 - 09.00 น.',
      appointmentType: 'อาคารพาณิชย์',
      detail: 'ห้องเลขที่ A-101 / แปลง 12',
      location: 'อาคารการท่าเรือแห่งประเทศไทย ชั้น 8 แผนกทะเบียนและสัญญา',
    );
  }

  factory BookingConfirmQueueModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmQueueModel(
      bookingId: json['bookingId'] as String? ?? '',
      queueNumber: json['queueNumber'] as String? ?? '',
      timeLabel: json['timeLabel'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      contractId: json['contractId'] as String? ?? '',
      appointmentDate: json['appointmentDate'] as String? ?? '',
      appointmentTime: json['appointmentTime'] as String? ?? '',
      appointmentType: json['appointmentType'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'queueNumber': queueNumber,
      'timeLabel': timeLabel,
      'customerName': customerName,
      'contractId': contractId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentType': appointmentType,
      'detail': detail,
      'location': location,
    };
  }
}
