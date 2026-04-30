import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';

import '../models/receipt_tax_invoice_request_model.dart';

abstract class ReceiptTaxInvoiceRemoteDataSource {
  Future<List<TaxInvoiceModel>> requestReceiptTaxInvoice(
    ReceiptTaxInvoiceRequestModel request,
  );
}

class ReceiptTaxInvoiceRemoteDataSourceImpl
    implements ReceiptTaxInvoiceRemoteDataSource {
  final List<TaxInvoiceModel> expenseTypes = const [
    TaxInvoiceModel(id: 1, name: 'ค่าเช่า'),
    TaxInvoiceModel(id: 2, name: 'ค่าน้ำ'),
    TaxInvoiceModel(id: 3, name: 'ค่าไฟ'),
    TaxInvoiceModel(id: 4, name: 'ค่าโทรศัพท์'),
  ];

  // @override
  // Future<List<ExpenseType>> getExpenseTypes() async {
  //   return Future.value(expenseTypes);
  // }

  @override
  Future<List<TaxInvoiceModel>> requestReceiptTaxInvoice(
    ReceiptTaxInvoiceRequestModel request,
  ) async {
    // Simulate API call using request.typeId
    return Future.value(expenseTypes);
  }
}
