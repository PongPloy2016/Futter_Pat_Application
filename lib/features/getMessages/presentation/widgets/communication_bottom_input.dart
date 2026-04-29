import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunicationBottomInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const CommunicationBottomInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFB0C4DE), width: 1), // Light blue-grey border
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'พิมพ์ข้อความ',
                  hintStyle: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 14.sp,
                    color: const Color(0xFFA0A0A0),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send_outlined, color: const Color(0xFF009ADB)),
              onPressed: onSend,
            ),
          ],
        ),
      ),
    );
  }
}
