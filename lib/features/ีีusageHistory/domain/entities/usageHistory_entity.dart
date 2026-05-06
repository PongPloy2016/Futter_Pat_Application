import 'package:equatable/equatable.dart';

enum UsageHistoryStatus { pending, completed }

class UsageHistoryEntity extends Equatable {
  final String id;
  final String billingMonth;
  final String meterReadDate;
  final double usageUnit;
  final String paymentDate;
  final double amount;
  final UsageHistoryStatus status;
  final String type; // rent, water, electricity, phone

  const UsageHistoryEntity({
    required this.id,
    required this.billingMonth,
    required this.meterReadDate,
    required this.usageUnit,
    required this.paymentDate,
    required this.amount,
    required this.status,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        billingMonth,
        meterReadDate,
        usageUnit,
        paymentDate,
        amount,
        status,
        type,
      ];
}
