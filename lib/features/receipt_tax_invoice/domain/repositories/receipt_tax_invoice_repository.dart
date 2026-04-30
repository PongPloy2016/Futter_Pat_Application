import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';

import '../entities/receipt_tax_invoice_request_entity.dart';

abstract class ReceiptTaxInvoiceRepository {
  Future<List<TaxInvoiceModel>> requestReceiptTaxInvoice(
    ReceiptTaxInvoiceRequestEntity request,
  );
}
