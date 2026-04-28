import '../../domain/entities/payment_card_entity.dart';

class PaymentCardModel extends PaymentCardEntity {
  const PaymentCardModel({
    required super.fullName,
    required super.companyCode,
    required super.ref1,
    required super.barcodeData,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      fullName: json['fullName'] ?? '',
      companyCode: json['companyCode'] ?? '',
      ref1: json['ref1'] ?? '',
      barcodeData: json['barcodeData'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'companyCode': companyCode,
      'ref1': ref1,
      'barcodeData': barcodeData,
    };
  }
}
