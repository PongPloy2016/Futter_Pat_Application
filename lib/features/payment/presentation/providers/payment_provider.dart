import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/payment_remote_datasource.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/get_payment_details_usecase.dart';

// Provider รับ contractId เป็น param ผ่าน family
final paymentDetailsProvider =
    FutureProvider.family<PaymentEntity, String>((ref, contractId) async {
  final dataSource = PaymentRemoteDataSourceImpl();
  final repository = PaymentRepositoryImpl(remoteDataSource: dataSource);
  final useCase = GetPaymentDetailsUseCase(repository);
  return useCase.execute(contractId);
});
