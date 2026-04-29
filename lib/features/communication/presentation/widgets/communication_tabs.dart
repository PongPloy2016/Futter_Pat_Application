import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunicationTabs extends StatelessWidget {
  const CommunicationTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF009ADB), width: 3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, color: const Color(0xFF009ADB), size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'ข้อความ',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF009ADB),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file, color: const Color(0xFF6B6B6B), size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'ไฟล์แนบ',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
