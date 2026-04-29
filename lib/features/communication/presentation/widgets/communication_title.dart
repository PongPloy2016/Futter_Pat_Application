import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunicationTitle extends StatelessWidget {
  const CommunicationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: const Color(0xFF009ADB),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'การสื่อสาร',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF009ADB),
          ),
        ),
      ],
    );
  }
}
