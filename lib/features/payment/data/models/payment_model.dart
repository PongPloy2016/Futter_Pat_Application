import '../../domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.contractId,
    required super.contractName,
    required super.rentalAmount,
    required super.penaltyAmount,
    required super.totalAmount,
    required super.dueDate,
    required super.qrCodeData,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      contractId: json['contractId'] ?? '',
      contractName: json['contractName'] ?? '',
      rentalAmount: (json['rentalAmount'] ?? 0).toDouble(),
      penaltyAmount: (json['penaltyAmount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      dueDate: json['dueDate'] ?? '',
      qrCodeData: json['qrCodeData'] ?? '',
    );
  }
}
