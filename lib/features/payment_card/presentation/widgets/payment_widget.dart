import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/text/custom_text.dart';

Widget buildDetailRow({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF009ADB), width: 1.5),
        ),
        child: Icon(icon, color: const Color(0xFF009ADB), size: 20.sp),
      ),
      SizedBox(width: 16.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.sp,
              fontFamily: 'Kanit',
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            value,
            textStyle: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
            ),
          ),
        ],
      ),
    ],
  );
}
