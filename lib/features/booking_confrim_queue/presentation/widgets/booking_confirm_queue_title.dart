import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_confirm_queue_header.dart';

class BookingConfirmQueueTitle extends StatelessWidget {
  const BookingConfirmQueueTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 32.h,
          decoration: const BoxDecoration(
            color: bookingConfirmQueuePrimaryBlue,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            'ยืนยันรอบเวลาการจองคิว',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: bookingConfirmQueuePrimaryBlue,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
