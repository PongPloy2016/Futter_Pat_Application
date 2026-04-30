import '../../domain/entities/receipt_tax_invoice_request_entity.dart';

class ReceiptTaxInvoiceRequestModel extends ReceiptTaxInvoiceRequestEntity {
  const ReceiptTaxInvoiceRequestModel({
    required super.typeId,
    required super.monthYear,
  });

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'month_year': monthYear,
    };
  }

  factory ReceiptTaxInvoiceRequestModel.fromEntity(ReceiptTaxInvoiceRequestEntity entity) {
    return ReceiptTaxInvoiceRequestModel(
      typeId: entity.typeId,
      monthYear: entity.monthYear,
    );
  }
}
