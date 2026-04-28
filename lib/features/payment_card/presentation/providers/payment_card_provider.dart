import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/payment_card_remote_datasource.dart';
import '../../data/repositories/payment_card_repository_impl.dart';
import '../../domain/usecases/get_payment_card_usecase.dart';
import '../../domain/entities/payment_card_entity.dart';

// State Provider (FutureProvider for async data)
final paymentCardStateProvider = FutureProvider<PaymentCardEntity>((ref) async {
  // สร้าง Dependency Injection แบบสั้นๆ ในที่เดียว
  final dataSource = PaymentCardRemoteDataSourceImpl();
  final repository = PaymentCardRepositoryImpl(remoteDataSource: dataSource);
  final useCase = GetPaymentCardUseCase(repository);
  
  // เรียกใช้งานผ่าน UseCase
  return useCase.execute();
});
