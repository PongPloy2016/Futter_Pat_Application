import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';

import '../entities/receipt_tax_invoice_request_entity.dart';
import '../repositories/receipt_tax_invoice_repository.dart';

class RequestReceiptTaxInvoiceUseCase {
  final ReceiptTaxInvoiceRepository repository;

  RequestReceiptTaxInvoiceUseCase(this.repository);

  Future<List<TaxInvoiceModel>> execute(
    ReceiptTaxInvoiceRequestEntity request,
  ) {
    return repository.requestReceiptTaxInvoice(request);
  }
}
