import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Footer with contact information
class BookingConfirmQueueContactFooter extends StatelessWidget {
  const BookingConfirmQueueContactFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Text(
            'ข้อมูลติดต่อ',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'โทรศัพท์ : 0-2269-3000, 0-2269-5000',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF777777),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            '(วันและเวลาทำการ จันทร์-ศุกร์ เวลา 08.30-16.30 น.)',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
