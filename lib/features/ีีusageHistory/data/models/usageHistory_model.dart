class UsageHistoryItemModel {
  final String id;
  final String billingMonth;
  final DateTime? meterReadDate;
  final double usageUnit;
  final DateTime? paymentDate;
  final double amount;
  final String status; // paid, unpaid, overdue
  final String type; // rent, water, electricity, phone

  UsageHistoryItemModel({
    required this.id,
    required this.billingMonth,
    required this.meterReadDate,
    required this.usageUnit,
    required this.paymentDate,
    required this.amount,
    required this.status,
    required this.type,
  });

  factory UsageHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return UsageHistoryItemModel(
      id: json['id'] ?? '',
      billingMonth: json['billingMonth'] ?? '',
      meterReadDate: json['meterReadDate'] != null
          ? DateTime.tryParse(json['meterReadDate'])
          : null,
      usageUnit: (json['usageUnit'] ?? 0).toDouble(),
      paymentDate: json['paymentDate'] != null
          ? DateTime.tryParse(json['paymentDate'])
          : null,
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'unpaid',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'billingMonth': billingMonth,
      'meterReadDate': meterReadDate?.toIso8601String(),
      'usageUnit': usageUnit,
      'paymentDate': paymentDate?.toIso8601String(),
      'amount': amount,
      'status': status,
      'type': type,
    };
  }
}