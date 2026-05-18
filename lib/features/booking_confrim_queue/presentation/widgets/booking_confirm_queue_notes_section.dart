import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Notes section — displays important notes about required documents
class BookingConfirmQueueNotesSection extends StatelessWidget {
  const BookingConfirmQueueNotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = [
      'บัตรประชาชน (ตัวจริง)',
      'ทะเบียนบ้าน (ตัวจริง)',
      'ใบเสร็จรับเงินประกัน',
      'ใบเสร็จค่าเช่าเดือนปัจจุบัน',
      'เอกสารมอบอำนาจ',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '* ',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: 'โปรดเตรียมเอกสารฉบับจริงมาในวันนัดหมาย ดังนี้:',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          ...notes.map(
            (note) => Padding(
              padding: EdgeInsets.only(left: 12.w, bottom: 3.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 12.sp,
                      color: const Color(0xFF555555),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      note,
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                      ),
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
