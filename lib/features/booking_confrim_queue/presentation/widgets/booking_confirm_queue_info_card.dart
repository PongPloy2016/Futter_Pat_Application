import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_confirm_queue_entity.dart';
import 'booking_confirm_queue_document_item.dart';

/// Redesigned info card matching the UI mockup
/// Shows: ประเภท, วันที่/เวลา, รายละเอียด, รายการนัดหมาย, เบอร์โทร, เอกสาร
class BookingConfirmQueueInfoCard extends StatelessWidget {
  const BookingConfirmQueueInfoCard({
    super.key,
    required this.booking,
  });

  final BookingConfirmQueueEntity booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── ประเภทการนัดหมาย ──
          _buildLabel('ประเภทการนัดหมาย'),
          SizedBox(height: 4.h),
          _buildValue(booking.appointmentType),
          _buildDivider(),

          // ── วันที่นัดหมาย + เวลานัดหมาย (2 columns) ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('วันที่นัดหมาย'),
                    SizedBox(height: 4.h),
                    _buildValue(booking.appointmentDate),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('เวลานัดหมาย'),
                    SizedBox(height: 4.h),
                    _buildValue(booking.appointmentTime),
                  ],
                ),
              ),
            ],
          ),
          _buildDivider(),

          // ── รายละเอียด ──
          _buildLabel('รายละเอียด'),
          SizedBox(height: 4.h),
          _buildValue(booking.detail),

          // ── รายการนัดหมาย ──
          if (booking.appointmentItems.isNotEmpty) ...[
            _buildDivider(),
            _buildLabel('รายการนัดหมาย'),
            SizedBox(height: 4.h),
            _buildValue(booking.appointmentItems),
          ],

          // ── เบอร์ที่ใช้ในการทำสัญญา ──
          if (booking.phone.isNotEmpty) ...[
            _buildDivider(),
            _buildLabel('เบอร์ที่ใช้ในการทำสัญญา'),
            SizedBox(height: 4.h),
            _buildValue(booking.phone),
          ],

          // ── เอกสารแนบที่อัปโหลด ──
          if (booking.documents.isNotEmpty) ...[
            _buildDivider(),
            _buildLabel('เอกสารแนบที่อัปโหลด'),
            SizedBox(height: 10.h),
            ...booking.documents.map(
              (doc) => BookingConfirmQueueDocumentItem(
                document: doc,
                onDownload: () {
                  // TODO: Implement download
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF888888),
        height: 1.3,
      ),
    );
  }

  Widget _buildValue(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF222222),
        height: 1.4,
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(
        height: 1.h,
        thickness: 0.7,
        color: const Color(0xFFE8E8E8),
      ),
    );
  }
}
