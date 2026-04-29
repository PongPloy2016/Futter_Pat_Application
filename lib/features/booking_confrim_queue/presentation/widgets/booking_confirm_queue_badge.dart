import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_confirm_queue_header.dart';

class BookingConfirmQueueBadge extends StatelessWidget {
  const BookingConfirmQueueBadge({
    super.key,
    required this.queueNumber,
    required this.timeLabel,
  });

  final String queueNumber;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 24.w,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 50.sp,
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
          Positioned(
            right: 24.w,
            child: Icon(
              Icons.chevron_right_rounded,
              size: 50.sp,
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
          Container(
            width: 150.w,
            height: 150.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: bookingConfirmQueuePrimaryBlue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'คิวที่',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  queueNumber,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                  child: Text(
                    timeLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
