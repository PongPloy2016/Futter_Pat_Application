import '../../../appointment/data/models/appointment_reserve_request_model.dart';
import '../entities/booking_confirm_queue_entity.dart';

abstract class BookingConfirmQueueRepository {
  Future<BookingConfirmQueueEntity> getBookingConfirmQueue(AppointmentReserveRequestModel request);
}
