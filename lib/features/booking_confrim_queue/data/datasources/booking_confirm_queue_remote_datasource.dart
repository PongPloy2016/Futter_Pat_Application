import '../models/booking_confirm_queue_model.dart';

abstract class BookingConfirmQueueRemoteDataSource {
  Future<BookingConfirmQueueModel> getBookingConfirmQueue(String bookingId);
}

class BookingConfirmQueueRemoteDataSourceImpl
    implements BookingConfirmQueueRemoteDataSource {
  @override
  Future<BookingConfirmQueueModel> getBookingConfirmQueue(
    String bookingId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return  BookingConfirmQueueModel(
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
}
