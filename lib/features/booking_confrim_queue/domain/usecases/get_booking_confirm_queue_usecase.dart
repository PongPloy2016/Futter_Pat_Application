import '../../../appointment/data/models/appointment_reserve_request_model.dart';
import '../entities/booking_confirm_queue_entity.dart';
import '../repositories/booking_confirm_queue_repository.dart';

class GetBookingConfirmQueueUseCase {
  final BookingConfirmQueueRepository repository;

  GetBookingConfirmQueueUseCase(this.repository);

  Future<BookingConfirmQueueEntity> execute(AppointmentReserveRequestModel request) {
    return repository.getBookingConfirmQueue(request);
  }
}
