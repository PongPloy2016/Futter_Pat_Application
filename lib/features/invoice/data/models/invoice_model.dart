import '../../domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.title,
    required super.month,
    required super.invoiceNumber,
    required super.amount,
    required super.dueDate,
    required super.status,
    required super.type,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      month: json['month'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      dueDate: json['dueDate'] ?? '',
      status: json['status'] == 'completed'
          ? InvoiceStatus.completed
          : InvoiceStatus.pending,
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'month': month,
      'invoiceNumber': invoiceNumber,
      'amount': amount,
      'dueDate': dueDate,
      'status': status == InvoiceStatus.completed ? 'completed' : 'pending',
      'type': type,
    };
  }
}
