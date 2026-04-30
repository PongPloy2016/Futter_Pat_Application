import 'package:equatable/equatable.dart';

class ReceiptTaxInvoiceRequestEntity extends Equatable {
  final int? typeId;
  final String? monthYear;

  const ReceiptTaxInvoiceRequestEntity({this.typeId, this.monthYear});

  ReceiptTaxInvoiceRequestEntity copyWith({int? typeId, String? monthYear}) {
    return ReceiptTaxInvoiceRequestEntity(
      typeId: typeId ?? this.typeId,
      monthYear: monthYear ?? this.monthYear,
    );
  }

  @override
  List<Object?> get props => [typeId, monthYear];
}
