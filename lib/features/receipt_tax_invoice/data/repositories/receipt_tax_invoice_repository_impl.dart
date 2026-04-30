import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';

import '../../domain/entities/receipt_tax_invoice_request_entity.dart';
import '../../domain/repositories/receipt_tax_invoice_repository.dart';
import '../datasources/receipt_tax_invoice_remote_datasource.dart';
import '../models/receipt_tax_invoice_request_model.dart';

class ReceiptTaxInvoiceRepositoryImpl implements ReceiptTaxInvoiceRepository {
  final ReceiptTaxInvoiceRemoteDataSource remoteDataSource;

  ReceiptTaxInvoiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TaxInvoiceModel>> requestReceiptTaxInvoice(
    ReceiptTaxInvoiceRequestEntity request,
  ) async {
    final model = ReceiptTaxInvoiceRequestModel.fromEntity(request);
    return await remoteDataSource.requestReceiptTaxInvoice(model);
  }
}
