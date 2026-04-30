import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../datasources/invoice_remote_datasource.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDataSource remoteDataSource;

  InvoiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<InvoiceEntity>> getInvoice() async {
    try {
      return await remoteDataSource.getInvoice();
    } catch (e) {
      throw Exception('Failed to get appointments: $e');
    }
  }
}
