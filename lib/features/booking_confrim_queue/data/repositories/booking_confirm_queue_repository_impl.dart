import '../../domain/entities/booking_confirm_queue_entity.dart';
import '../../domain/repositories/booking_confirm_queue_repository.dart';
import '../datasources/booking_confirm_queue_remote_datasource.dart';

class BookingConfirmQueueRepositoryImpl
    implements BookingConfirmQueueRepository {
  final BookingConfirmQueueRemoteDataSource remoteDataSource;

  BookingConfirmQueueRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BookingConfirmQueueEntity> getBookingConfirmQueue(
    String bookingId,
  ) async {
    try {
      return await remoteDataSource.getBookingConfirmQueue(bookingId);
    } catch (e) {
      throw Exception('Failed to load booking confirm queue data');
    }
  }
}
