import '../models/usageHistory_model.dart';

abstract class UsageHistoryDataSource {
  Future<List<UsageHistoryItemModel>> getUsageHistory();
}

class UsageHistoryDataSourceImpl implements UsageHistoryDataSource {
  @override
  Future<List<UsageHistoryItemModel>> getUsageHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data based on UI design
    final mockJson = [
      // Rent - Paid (Blue)

      {
        'id': 'R001',
        'billingMonth': 'มกราคม 2569',
        'meterReadDate': '2026-02-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-02-10',
        'amount': 120.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R002',
        'billingMonth': 'กุมภาพันธ์ 2569',
        'meterReadDate': '2026-02-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-02-10',
        'amount': 230.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R003',
        'billingMonth': 'มีนาคม 2569',
        'meterReadDate': '2026-03-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-03-10',
        'amount': 440.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R004',
        'billingMonth': 'เมษายน 2569',
        'meterReadDate': '2026-04-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-03-10',
        'amount': 540.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R005',
        'billingMonth': 'พฤษภาคม 2569',
        'meterReadDate': '2026-03-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-03-10',
        'amount': 500.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R006',
        'billingMonth': 'มิถุนายน 2569',
        'meterReadDate': '2026-06-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-06-10',
        'amount': 600.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R007',
        'billingMonth': 'กรกฎาคม 2569',
        'meterReadDate': '2026-07-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-07-10',
        'amount': 440.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R008',
        'billingMonth': 'สิงหาคม 2569',
        'meterReadDate': '2026-08-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-08-10',
        'amount': 1000.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R009',
        'billingMonth': 'กันยายน 2569',
        'meterReadDate': '2026-09-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-09-10',
        'amount': 345.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R010',
        'billingMonth': 'ตุลาคม 2569',
        'meterReadDate': '2026-10-01',
        'usageUnit': 400.0,
        'paymentDate': '2026-10-10',
        'amount': 440.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R011',
        'billingMonth': 'พฤศจิกายน 2569',
        'meterReadDate': '2026-11-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-11-10',
        'amount': 440.0,
        'status': 'paid',
        'type': 'water'
      },
      {
        'id': 'R012',
        'billingMonth': 'ธันวาคม 2569',
        'meterReadDate': '2026-12-01',
        'usageUnit': 1200.0,
        'paymentDate': '2026-12-10',
        'amount': 440.0,
        'status': 'paid',
        'type': 'water'
      },

      // Electricity - Pending (Red)
      {
        'id': 'E001',
        'billingMonth': 'มกราคม 2569',
        'meterReadDate': '2026-01-20',
        'usageUnit': 150.0,
        'paymentDate': null,
        'amount': 650.0,
        'status': 'unpaid',
        'type': 'electricity'
      },

      // Phone - Overdue (Yellow)
      {
        'id': 'P001',
        'billingMonth': 'มกราคม 2569',
        'meterReadDate': null,
        'usageUnit': 0.0,
        'paymentDate': null,
        'amount': 450.0,
        'status': 'overdue',
        'type': 'phone'
      },

      // Water - Paid (Blue)

      // Electricity - Paid (Blue)
      {
        'id': 'E002',
        'billingMonth': 'ธันวาคม 2568',
        'meterReadDate': '2025-12-15',
        'usageUnit': 140.0,
        'paymentDate': '2026-01-05',
        'amount': 600.0,
        'status': 'paid',
        'type': 'electricity'
      },

      // Rent - Pending (Red)
      {
        'id': 'R002',
        'billingMonth': 'ธันวาคม 2568',
        'meterReadDate': '2025-12-01',
        'usageUnit': 0.0,
        'paymentDate': null,
        'amount': 1500.0,
        'status': 'unpaid',
        'type': 'rent'
      },

      // Phone - Paid (Blue)
      {
        'id': 'P002',
        'billingMonth': 'พฤศจิกายน 2568',
        'meterReadDate': null,
        'usageUnit': 0.0,
        'paymentDate': '2025-12-20',
        'amount': 400.0,
        'status': 'paid',
        'type': 'phone'
      },
    ];

    return mockJson
        .map((json) => UsageHistoryItemModel.fromJson(json))
        .toList();
  }
}
