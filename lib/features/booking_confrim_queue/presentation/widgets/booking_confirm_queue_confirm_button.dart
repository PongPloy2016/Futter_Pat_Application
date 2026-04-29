import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_confirm_queue_header.dart';

class BookingConfirmQueueConfirmButton extends StatelessWidget {
  const BookingConfirmQueueConfirmButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212.w,
      height: 40.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          boxShadow: [
            BoxShadow(
              color: bookingConfirmQueuePrimaryBlue.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bookingConfirmQueuePrimaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
          child: Text(
            'ยืนยันการนัดหมาย',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
