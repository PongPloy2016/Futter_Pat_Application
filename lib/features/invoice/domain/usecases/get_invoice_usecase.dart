import '../entities/invoice_entity.dart';

import '../repositories/invoice_repository.dart';

class GetInvoiceUseCase {
  final InvoiceRepository repository;

  GetInvoiceUseCase(this.repository);

  Future<List<InvoiceEntity>> execute() {
    return repository.getInvoice();
  }
}
