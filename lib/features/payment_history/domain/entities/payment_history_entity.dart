import 'package:equatable/equatable.dart';

enum PaymentHistoryStatus { pending, completed }

class PaymentHistoryEntity extends Equatable {
  final String id;
  final String title;
  final String month;
  final String invoiceNumber;
  final double amount;
  final String dueDate;
  final PaymentHistoryStatus status;
  final String type; // rent, water, electricity, phone

  const PaymentHistoryEntity({
    required this.id,
    required this.title,
    required this.month,
    required this.invoiceNumber,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        month,
        invoiceNumber,
        amount,
        dueDate,
        status,
        type,
      ];
}
