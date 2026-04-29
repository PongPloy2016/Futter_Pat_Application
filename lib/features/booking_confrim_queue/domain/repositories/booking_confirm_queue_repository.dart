import '../entities/booking_confirm_queue_entity.dart';

abstract class BookingConfirmQueueRepository {
  Future<BookingConfirmQueueEntity> getBookingConfirmQueue(String bookingId);
}
