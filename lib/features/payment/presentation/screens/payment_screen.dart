import 'package:flutter/material.dart';
import 'package:flutter_pat_application/features/payment/presentation/widgets/payment_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/payment_entity.dart';
import '../providers/payment_provider.dart';

class PaymentScreen extends ConsumerWidget {
  final String contractId;

  const PaymentScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentDetailsProvider(contractId));

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: paymentState.when(
                data: (data) => _buildContent(context, data),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009ADB), width: 1.5),
              ),
              child: Icon(
                Icons.arrow_back,
                color: const Color(0xFF009ADB),
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, PaymentEntity data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Container(
                width: 5.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF009ADB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'ชำระเงิน',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF009ADB),
                  fontFamily: 'Kanit',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Contract Info Card
          _buildContractInfoCard(data),
          SizedBox(height: 16.h),

          // QR Code Card
          PaymentQrCodeCard(data: data, formatNumber: _formatNumber),
          SizedBox(height: 16.h),

          // Bank Info
          PaymentBankInfoCard(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildContractInfoCard(PaymentEntity data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAAAACC).withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(18.w),
      child: Column(
        children: [
          PaymentInfoRow(
            label: 'เลขที่สัญญา',
            value: data.contractId,
            valueStyle: const TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
            ),
          ),
          const PaymentDivider(),
          PaymentInfoRow(
            label: 'ชื่อสัญญา',
            value: data.contractName,
            valueStyle: const TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
            ),
          ),
          const PaymentDivider(),
          PaymentInfoRow(
            label: 'ค่าเช่า',
            value: '${_formatNumber(data.rentalAmount)} บาท',
            valueStyle: const TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
            ),
          ),
          const PaymentDivider(),
          PaymentInfoRow(
            label: 'ค่าปรับ',
            value: '${_formatNumber(data.penaltyAmount)} บาท',
            valueStyle: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
              color: data.penaltyAmount > 0
                  ? const Color(0xFFE53935)
                  : Colors.black87,
            ),
          ),
          const PaymentDivider(),
          PaymentInfoRow(
            label: 'ยอดที่ต้องชำระ',
            value: '${_formatNumber(data.totalAmount)} บาท',
            valueStyle: const TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
              color: Color(0xFF009ADB),
            ),
          ),
          const PaymentDivider(),
          PaymentInfoRow(
            label: 'กำหนดชำระ',
            value: data.dueDate,
            valueStyle: const TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double value) {
    final intVal = value.toInt();
    final str = intVal.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write(',');
    }
    return buffer.toString().split('').reversed.join('');
  }
}
