import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

const Color bookingConfirmQueuePrimaryBlue = Color(0xFF009ADB);

class BookingConfirmQueueHeader extends StatelessWidget {
  const BookingConfirmQueueHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: bookingConfirmQueuePrimaryBlue,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: bookingConfirmQueuePrimaryBlue,
              size: 24.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Image.asset(
            'lib/assets/icons/ic_profile_mock.png',
            width: 34.w,
            height: 34.w,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
