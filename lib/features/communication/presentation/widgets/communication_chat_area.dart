import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/chat_message_entity.dart';

class CommunicationChatArea extends StatelessWidget {
  final AsyncValue<List<ChatMessageEntity>> chatState;

  const CommunicationChatArea({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '10 ม.ค. 2569',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFA0A0A0),
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        chatState.when(
          data: (messages) {
            return Column(
              children: messages
                  .map((msg) => _buildMessageBubble(msg))
                  .toList(),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF009ADB)),
          ),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessageEntity message) {
    if (message.isSender) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 48.w), // spacing for the left side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        message.time,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 12.sp,
                          color: const Color(0xFFA0A0A0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009ADB), width: 1.5),
              ),
              child: Icon(
                Icons.person_outline,
                color: const Color(0xFF009ADB),
                size: 20.w,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: Color(0xFF4285F4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent_rounded,
                color: Colors.white,
                size: 24.w,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        message.time,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 12.sp,
                          color: const Color(0xFFA0A0A0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 48.w), // spacing for the right side
          ],
        ),
      );
    }
  }
}
