import '../../domain/entities/payment_history_entity.dart';
import '../models/payment_history_model.dart';

abstract class PaymentHistoryDataSource {
  Future<List<PaymentHistoryModel>> getPaymentHistory();
}

class PaymentHistoryDataSourceImpl implements PaymentHistoryDataSource {
  @override
  Future<List<PaymentHistoryModel>> getPaymentHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data based on UI design
    final mockJson = [
      PaymentHistoryModel(
        id: '1',
        type: PaymentHistoryType.rent,
        title: 'ค่าเช่า',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0001',
        amount: 15000,
        dueDate: DateTime(2026, 2, 10),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '2',
        type: PaymentHistoryType.water,
        title: 'ค่าน้ำ',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0002',
        amount: 150,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '3',
        type: PaymentHistoryType.electricity,
        title: 'ค่าไฟ',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0003',
        amount: 1500,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '4',
        type: PaymentHistoryType.phone,
        title: 'ค่าโทรศัพท์',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0004',
        amount: 1200,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '4',
        type: PaymentHistoryType.phone,
        title: 'ค่าโทรศัพท์',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0004',
        amount: 1200,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '4',
        type: PaymentHistoryType.phone,
        title: 'ค่าโทรศัพท์',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0004',
        amount: 1200,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
      PaymentHistoryModel(
        id: '4',
        type: PaymentHistoryType.phone,
        title: 'ค่าโทรศัพท์',
        monthText: 'มกราคม 2569',
        documentNo: 'INV-2026-0004',
        amount: 1200,
        dueDate: DateTime(2026, 2, 1),
        status: PaymentStatus.paid,
      ),
    ];

    return mockJson;
  }
}
