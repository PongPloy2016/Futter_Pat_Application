import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/document_entity.dart';

class DocumentRequirementCard extends StatelessWidget {
  const DocumentRequirementCard({
    super.key,
    required this.title,
    required this.documents,
    required this.powerOfAttorneyDocuments,
    required this.onAttach,
    required this.selectedFiles,
    required this.onDeleteFile,
  });

  final String title;
  final List<String> documents;
  final List<String> powerOfAttorneyDocuments;
  final VoidCallback onAttach;
  final List<DocumentEntity> selectedFiles;
  final Function(DocumentEntity) onDeleteFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        gradient: const LinearGradient(
          colors: [Color(0xFFEDEFF8), Colors.white],
          stops: [0.0, 0.25],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2B478B),
              ),
            ),
            SizedBox(height: 12.h),
            ...documents.map(
              (doc) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  doc,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF222222),
                    height: 1.4,
                  ),
                ),
              ),
            ),
            if (powerOfAttorneyDocuments.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                'กรณีมอบอำนาจ (ถ้ามี)',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2B478B),
                ),
              ),
              SizedBox(height: 12.h),
              ...powerOfAttorneyDocuments.map(
                (doc) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    doc,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF222222),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 16.h),
            Row(
              children: [
                SizedBox(
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: onAttach,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3A93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      elevation: 2,
                    ),
                    child: Text(
                      'แนบไฟล์',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (selectedFiles.isNotEmpty) ...[
              SizedBox(height: 16.h),
              ...selectedFiles.map((file) {
                final fileSizeInMB = (file.size / (1024 * 1024))
                    .toStringAsFixed(2);
                final fileExt = file.extension?.toUpperCase() ?? '';
                final now = DateTime.now();
                final months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                ];
                final dateStr =
                    '${now.day} ${months[now.month - 1]}, ${now.year}';

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // fileExt == 'PDF'
                            //     ? Stack(
                            //         children: [
                            //           Icon(
                            //             Icons.insert_drive_file,
                            //             color: Colors.grey.shade300,
                            //             size: 36.sp,
                            //           ),
                            //           Positioned(
                            //             bottom: 4.h,
                            //             child: Container(
                            //               padding: EdgeInsets.symmetric(
                            //                 horizontal: 4.w,
                            //                 vertical: 2.h,
                            //               ),
                            //               decoration: BoxDecoration(
                            //                 color: fileExt == 'PDF'
                            //                     ? Colors.red
                            //                     : Colors.purpleAccent,
                            //                 borderRadius: BorderRadius.circular(
                            //                   4.r,
                            //                 ),
                            //               ),
                            //               child: Text(
                            //                 fileExt.isNotEmpty
                            //                     ? fileExt
                            //                     : 'FILE',
                            //                 style: TextStyle(
                            //                   fontSize: 8.sp,
                            //                   fontWeight: FontWeight.bold,
                            //                   color: Colors.white,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       )
                            //     : Image.file(
                            //         File(file.path!),
                            //         height: 40,
                            //         width: 40,
                            //       ),
                            Icon(
                              Icons.insert_drive_file,
                              color: Colors.grey.shade300,
                              size: 36.sp,
                            ),
                            Positioned(
                              bottom: 4.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: fileExt == 'PDF'
                                      ? Colors.red
                                      : Colors.purpleAccent,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  fileExt.isNotEmpty ? fileExt : 'FILE',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file.name,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 14.sp,
                                  color: const Color(0xFF222222),
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '$fileSizeInMB MB . $dateStr',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 24.sp,
                            color: Colors.red.shade400,
                          ),
                          onPressed: () => onDeleteFile(file),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
