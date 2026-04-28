class PaymentEntity {
  final String contractId;
  final String contractName;
  final double rentalAmount;
  final double penaltyAmount;
  final double totalAmount;
  final String dueDate;
  final String qrCodeData;

  const PaymentEntity({
    required this.contractId,
    required this.contractName,
    required this.rentalAmount,
    required this.penaltyAmount,
    required this.totalAmount,
    required this.dueDate,
    required this.qrCodeData,
  });
}
