import 'package:equatable/equatable.dart';

class PaymentCardEntity extends Equatable {
  final String fullName;
  final String companyCode;
  final String ref1;
  final String barcodeData;

  const PaymentCardEntity({
    required this.fullName,
    required this.companyCode,
    required this.ref1,
    required this.barcodeData,
  });

  @override
  List<Object?> get props => [fullName, companyCode, ref1, barcodeData];
}
