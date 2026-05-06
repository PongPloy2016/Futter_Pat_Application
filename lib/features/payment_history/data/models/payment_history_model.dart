import '../../domain/entities/payment_history_entity.dart';
class PaymentHistoryModel {
  final String id;
  final PaymentHistoryType type;
  final String title;
  final String monthText;
  final String documentNo;
  final double amount;
  final DateTime dueDate;
  final PaymentStatus status;
  final DateTime? paidDate;

  PaymentHistoryModel({
    required this.id,
    required this.type,
    required this.title,
    required this.monthText,
    required this.documentNo,
    required this.amount,
    required this.dueDate,
    required this.status,
    this.paidDate,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      id: json['id'] ?? '',
      type: PaymentHistoryType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaymentHistoryType.rent,
      ),
      title: json['title'] ?? '',
      monthText: json['monthText'] ?? '',
      documentNo: json['documentNo'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      dueDate: DateTime.parse(json['dueDate']),
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PaymentStatus.unpaid,
      ),
      paidDate: json['paidDate'] != null
          ? DateTime.parse(json['paidDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'monthText': monthText,
      'documentNo': documentNo,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'paidDate': paidDate?.toIso8601String(),
    };
  }
}

enum PaymentHistoryType {
  all,
  rent,
  water,
  electricity,
  phone,
}

extension PaymentHistoryTypeExt on PaymentHistoryType {
  String get label {
    switch (this) {
      case PaymentHistoryType.all:
        return 'ทั้งหมด';
      case PaymentHistoryType.rent:
        return 'ค่าเช่า';
      case PaymentHistoryType.water:
        return 'ค่าน้ำ';
      case PaymentHistoryType.electricity:
        return 'ค่าไฟ';
      case PaymentHistoryType.phone:
        return 'ค่าโทรศัพท์';
    }
  }
}

enum PaymentStatus {
  paid,
  unpaid,
  overdue,
}

extension PaymentStatusExt on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.paid:
        return 'ชำระแล้ว';
      case PaymentStatus.unpaid:
        return 'รอชำระ';
      case PaymentStatus.overdue:
        return 'เกินกำหนด';
    }
  }
}