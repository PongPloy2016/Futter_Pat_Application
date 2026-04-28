import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentModel> getPaymentDetails(String contractId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  @override
  Future<PaymentModel> getPaymentDetails(String contractId) async {
    // จำลองข้อมูลจาก API
    await Future.delayed(const Duration(milliseconds: 800));
    return PaymentModel(
      contractId: contractId.isNotEmpty ? contractId : '2101/2569',
      contractName: 'นายสมชาย ใจดี',
      rentalAmount: 15000,
      penaltyAmount: 150,
      totalAmount: 15150,
      dueDate: '10 กุมภาพันธ์ 2569',
      qrCodeData: '001504640511000101001${contractId}',
    );
  }
}
