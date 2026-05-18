import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/booking_confirm_queue_remote_datasource.dart';
import '../../data/repositories/booking_confirm_queue_repository_impl.dart';
import '../../domain/usecases/get_booking_confirm_queue_usecase.dart';
import '../../domain/entities/booking_confirm_queue_entity.dart';
import '../../../appointment/data/models/appointment_reserve_request_model.dart';
final bookingConfirmQueueProvider =
    FutureProvider.family<BookingConfirmQueueEntity, AppointmentReserveRequestModel>((
      ref,
      AppointmentReserveRequestModel request,
    ) async {
      final remoteDataSource = BookingConfirmQueueRemoteDataSourceImpl();
      final repository = BookingConfirmQueueRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );
        final useCase = GetBookingConfirmQueueUseCase(repository);
        return useCase.execute(request);
    
    });
