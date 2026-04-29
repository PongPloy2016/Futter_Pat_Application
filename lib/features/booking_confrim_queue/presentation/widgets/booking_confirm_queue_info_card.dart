import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_confirm_queue_entity.dart';

class BookingConfirmQueueInfoCard extends StatelessWidget {
  const BookingConfirmQueueInfoCard({
    super.key,
    required this.booking,
  });

  final BookingConfirmQueueEntity booking;

  @override
  Widget build(BuildContext context) {
    final rows = [
      _BookingConfirmQueueInfoRow('รหัสลูกหนี้', booking.bookingId),
      _BookingConfirmQueueInfoRow('เลขที่สัญญา', booking.contractId),
      _BookingConfirmQueueInfoRow('ชื่อ-นามสกุล', booking.customerName),
      _BookingConfirmQueueInfoRow('วันที่นัดหมาย', booking.appointmentDate),
      _BookingConfirmQueueInfoRow('เวลานัดหมาย', booking.appointmentTime),
      _BookingConfirmQueueInfoRow('ประเภท', booking.appointmentType),
      _BookingConfirmQueueInfoRow('รายละเอียด', booking.detail),
      _BookingConfirmQueueInfoRow('สถานที่', booking.location),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(26.w, 14.h, 26.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFF),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5D5E96).withValues(alpha: 0.16),
            blurRadius: 22,
            offset: const Offset(-10, 0),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.88),
            blurRadius: 18,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int index = 0; index < rows.length; index++) ...[
            _buildInfoRow(rows[index]),
            if (index != rows.length - 1)
              Divider(
                height: 1.h,
                thickness: 0.7,
                color: const Color(0xFFD2D2D2),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(_BookingConfirmQueueInfoRow row) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112.w,
            child: Text(
              row.label,
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF777777),
                height: 1.25,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              row.value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111111),
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingConfirmQueueInfoRow {
  const _BookingConfirmQueueInfoRow(this.label, this.value);

  final String label;
  final String value;
}
