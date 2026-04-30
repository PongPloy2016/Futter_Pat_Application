import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptTaxInvoiceHeader extends StatelessWidget {
  final String title;

  const ReceiptTaxInvoiceHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: const Color(0xFF009ADB),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF009ADB),
          ),
        ),
      ],
    );
  }
}
