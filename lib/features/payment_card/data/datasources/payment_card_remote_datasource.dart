import '../models/payment_card_model.dart';

abstract class PaymentCardRemoteDataSource {
  Future<PaymentCardModel> getPaymentCardDetails();
}

class PaymentCardRemoteDataSourceImpl implements PaymentCardRemoteDataSource {
  @override
  Future<PaymentCardModel> getPaymentCardDetails() async {
    // TODO: Implement API call using Dio/Retrofit
    // Mock data for now
    await Future.delayed(const Duration(seconds: 1));
    return const PaymentCardModel(
      fullName: 'นายสมชาย ใจดี',
      companyCode: 'P001',
      ref1: '001504640511000101001',
      barcodeData: '001504640511000101001',
    );
  }
}
