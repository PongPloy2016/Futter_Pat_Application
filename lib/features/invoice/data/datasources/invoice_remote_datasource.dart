import '../models/invoice_model.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<InvoiceModel>> getInvoice();
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  @override
  Future<List<InvoiceModel>> getInvoice() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data based on UI design
    final mockJson = [
      {
        'id': '1',
        'title': 'ค่าเช่า',
        'month': 'มกราคม 2569',
        'invoiceNumber': 'INV-2026-0001',
        'amount': 15000.0,
        'dueDate': '10 กุมภาพันธ์ 2569',
        'status': 'pending',
        'type': 'rent',
      },
      {
        'id': '2',
        'title': 'ค่าน้ำ',
        'month': 'มกราคม 2569',
        'invoiceNumber': 'INV-2026-0002',
        'amount': 150.0,
        'dueDate': '1 กุมภาพันธ์ 2569',
        'status': 'pending',
        'type': 'water',
      },
      {
        'id': '3',
        'title': 'ค่าไฟ',
        'month': 'มกราคม 2569',
        'invoiceNumber': 'INV-2026-0003',
        'amount': 1200.0,
        'dueDate': '5 กุมภาพันธ์ 2569',
        'status': 'pending',
        'type': 'electricity',
      },
      {
        'id': '2',
        'title': 'ค่าน้ำ',
        'month': 'มกราคม 2569',
        'invoiceNumber': 'INV-2026-0002',
        'amount': 150.0,
        'dueDate': '1 กุมภาพันธ์ 2569',
        'status': 'pending',
        'type': 'water',
      },
      {
        'id': '3',
        'title': 'ค่าไฟ',
        'month': 'มกราคม 2569',
        'invoiceNumber': 'INV-2026-0003',
        'amount': 1200.0,
        'dueDate': '5 กุมภาพันธ์ 2569',
        'status': 'pending',
        'type': 'electricity',
      },
    ];

    return mockJson.map((json) => InvoiceModel.fromJson(json)).toList();
  }
}
