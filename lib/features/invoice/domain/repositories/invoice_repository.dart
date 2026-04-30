import 'package:flutter_pat_application/features/invoice/domain/entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceEntity>> getInvoice();
}