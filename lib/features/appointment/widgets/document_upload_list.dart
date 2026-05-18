import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'appointment_reserve_widgets.dart';
import 'appointment_widget.dart';

/// Builds a dynamic list of document upload cards from a list of items
class DocumentUploadList extends StatelessWidget {
  const DocumentUploadList({
    super.key,
    required this.items,
    required this.uploadedFiles,
    required this.onUpload,
    required this.onDelete,
  });

  final List<DocumentUploadItem> items;
  final Map<String, String> uploadedFiles; // title -> filePath
  final void Function(DocumentUploadItem item) onUpload;
  final void Function(DocumentUploadItem item) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => DocumentUploadCard(
              item: item,
              filePath: uploadedFiles[item.title],
              onUpload: () => onUpload(item),
              onDelete: onDelete,
            ),
          )
          .toList(),
    );
  }
}

/// Model for a single document upload field
class DocumentUploadItem {
  final String title;
  final bool isRequired;

  const DocumentUploadItem({required this.title, this.isRequired = false});
}

/// Widget for a single document upload card with title, upload area, and file info
class DocumentUploadCard extends StatelessWidget {
  const DocumentUploadCard({
    super.key,
    required this.item,
    this.onUpload,
    this.filePath,
    required this.onDelete,
  });

  final DocumentUploadItem item;
  final VoidCallback? onUpload;
  final String? filePath;
  final void Function(DocumentUploadItem item) onDelete;

  String _getFileSize(String path) {
    try {
      final file = File(path);
      final bytes = file.lengthSync();
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB"];
      var i = (log(bytes) / log(1024)).floor();
      return "${(bytes / pow(1024, i)).toStringAsFixed(0)} ${suffixes[i]}";
    } catch (e) {
      return "0 B";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filePath != null) {
      final String fileName = filePath!.split(Platform.pathSeparator).last;
      final String fileSize = _getFileSize(filePath!);

      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE0E4F0)),
        ),
        child: Row(
          children: [
            // File Icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.insert_drive_file_outlined,
                color: const Color(0xFFA0AABF),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Name & Size
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    fileSize,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 11.sp,
                      color: const Color(0xFFA0AABF),
                    ),
                  ),
                ],
              ),
            ),

            // Download Button
            IconButton(
              onPressed: () {
                // Future implementation for download
              },
              icon: Icon(
                Icons.file_download_outlined,
                color: appointmentPrimaryBlue,
                size: 24.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: 12.w),

            // Delete Button
            IconButton(
              onPressed: () => onDelete(item),
              icon: Icon(
                Icons.delete_outline,
                color: const Color(0xFFE84C4C),
                size: 24.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    }

    // Default Upload Box
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE0E4F0)),
      ),
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8F9AAB),
                ),
                children: [
                  TextSpan(text: item.title),
                  if (item.isRequired)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 13.sp,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Upload area
            GestureDetector(
              onTap: onUpload,
              child: Container(
                width: 86.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFE),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: const Color(0xFFE0E4F0),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: const Color(0xFFB5BED0),
                      size: 24.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Upload',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 12.sp,
                        color: const Color(0xFFB5BED0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Size limit info
            Text(
              '(ขนาดไฟล์ไม่เกิน 5MB)',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 11.sp,
                color: const Color(0xFFA0AABF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
