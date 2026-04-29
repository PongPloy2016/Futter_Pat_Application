import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CommunicationHeader extends StatelessWidget {
  const CommunicationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009ADB), width: 1.5),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFF009ADB),
                size: 24.sp,
              ),
            ),
          ),
          // User avatar mock
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: const BoxDecoration(
              color: Color(0xFF4285F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 32.w,
            ),
          ),
        ],
      ),
    );
  }
}
