import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptTaxInvoiceInfoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ReceiptTaxInvoiceInfoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 120.w,
            height: 120.w,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.description_outlined,
              size: 100.sp,
              color: const Color(0xFF009ADB).withOpacity(0.2),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: const Color(0xFF666666),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
