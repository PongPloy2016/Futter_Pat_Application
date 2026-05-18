import 'package:flutter/material.dart';
import 'package:flutter_pat_application/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/logo/logo_create_pin.dart';

/// Badge widget: PAT Logo + "นัดหมายคิวที่" + queue number (large)
/// Displayed inside a blue gradient card at the top of the screen
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
    return Container(
      // width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 20.w),
      // padding: EdgeInsets.symmetric(vertical: 28.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PAT Logo

          // "การท่าเรือแห่งประเทศไทย" text

          // "นัดหมายคิวที่" label
          Container(
            // decoration: BoxDecoration(
            //   color: Color(primaryBlueLight),
            //   borderRadius: BorderRadius.circular(14.r),
            //   border: Border.all(
            //     color: Colors.white.withValues(alpha: 0.2),
            //     width: 1,
            //   ),
            // ),
            child: Column(
              children: [
                Text(
                  'นัดหมายคิวที่',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(bookingItemCard1Color),
                  ),
                ),
                SizedBox(height: 8.h),
                // Queue Number (large)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    queueNumber,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(bookingItemCard1Color),
                      height: 1.1,
                      letterSpacing: 6,
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
