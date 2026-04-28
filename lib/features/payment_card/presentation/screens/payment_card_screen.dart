import 'package:flutter/material.dart';
import 'package:flutter_pat_application/features/payment_card/data/models/payment_card_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pat_application/shared/widgets/text/custom_text.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../domain/entities/payment_card_entity.dart';
import '../providers/payment_card_provider.dart';
import '../widgets/payment_widget.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:go_router/go_router.dart';

class PaymentCardScreen extends ConsumerWidget {
  const PaymentCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentCardState = ref.watch(paymentCardStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light greyish background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    SizedBox(height: 24.h),
                    paymentCardState.when(
                      data: (data) => _buildPaymentCard(data),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                  ],
                ),
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
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: const Color(0xFF009ADB),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        CustomText(
          'บัตรชำระเงิน',
          textStyle: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF009ADB),
            fontFamily: 'Kanit',
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(PaymentCardEntity data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          // Logos Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PAT Logo
                Image.asset(
                  'lib/assets/images/pat_logo_image.png',
                  height: 40.h,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.business, color: Colors.blue),
                ),
                SizedBox(width: 16.w),
                Container(height: 40.h, width: 1, color: Colors.grey[300]),
                SizedBox(width: 16.w),
                // Krungthai Logo Placeholder
                Image.asset(
                  'lib/assets/images/ic_krungthai_bank_logo.png',
                  height: 60.h,
                  width: 100.w,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.business, color: Colors.blue),
                  fit: BoxFit.contain,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       children: [
                //         Icon(
                //           Icons.account_balance,
                //           color: const Color(0xFF1EA1D7),
                //           size: 24.sp,
                //         ),
                //         SizedBox(width: 4.w),
                //         CustomText(
                //           'ธนาคารกรุงไทย',
                //           textStyle: TextStyle(
                //             color: const Color(0xFF1EA1D7),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16.sp,
                //             fontFamily: 'Kanit',
                //           ),
                //         ),
                //       ],
                //     ),
                //     CustomText(
                //       'KRUNGTHAI BANK',
                //       textStyle: TextStyle(
                //         color: const Color(0xFF1EA1D7),
                //         fontSize: 10.sp,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Kanit',
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Blue Banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 24.w,
                top: 12.h,
                bottom: 15.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF009ADB),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomText(
                'ชำระเงินผ่านธนาคารกรุงไทย ได้ทุกสาขา',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Details List
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                buildDetailRow(
                  icon: Icons.person_outline,
                  label: 'ชื่อ-นามสกุล',
                  value: data.fullName,
                ),
                Divider(color: Colors.grey[300], height: 24.h),
                buildDetailRow(
                  icon: Icons.domain,
                  label: 'Company Code',
                  value: data.companyCode,
                ),
                Divider(color: Colors.grey[300], height: 24.h),
                buildDetailRow(
                  icon: Icons.description_outlined,
                  label: 'Ref. 1',
                  value: data.ref1,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Barcode Placeholder Area
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1F6), // Light blue-grey background
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Container(
                color: Colors.white,
                child: SfBarcodeGenerator(
                  value: data.barcodeData,
                  symbology: Codabar(),
                  showValue: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          // Save Button
          GestureDetector(
            onTap: () {
              // TODO: Implement save card action
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF009ADB),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF009ADB).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CustomText(
                'บันทึกบัตร',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
