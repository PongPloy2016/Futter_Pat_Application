import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_confirm_queue_entity.dart';

/// Document item widget — shows icon, file name, size, and download button
class BookingConfirmQueueDocumentItem extends StatelessWidget {
  const BookingConfirmQueueDocumentItem({
    super.key,
    required this.document,
    this.onDownload,
  });

  final BookingDocumentEntity document;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // File icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.description_outlined,
              color: const Color(0xFF009ADB),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          // File name + size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.fileName,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF333333),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  document.fileSize,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          // Download button
          GestureDetector(
            onTap: onDownload,
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFF009ADB).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.download_rounded,
                color: const Color(0xFF009ADB),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
