import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/check_appointment_entity.dart';

class CheckAppointmentCard extends StatelessWidget {
  const CheckAppointmentCard({super.key, required this.appointment});

  final CheckAppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    final isPending = appointment.status == CheckAppointmentStatus.pending;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(
              0xFFF3F5F9,
            ), // Very light top background matching design
            Colors.white,
          ],
          stops: const [0.0, 0.4],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Queue Number and Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'คิวที่ ${appointment.queueNumber}',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFDF0D5)
                      : const Color(0xFFDFF0D8),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isPending ? 'รอดำเนินการ' : 'เสร็จสิ้น',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isPending
                        ? const Color(0xFFE28B00)
                        : const Color(0xFF3C763D),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Contract Number
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80.w,
                child: Text(
                  'เลขที่สัญญา',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  appointment.contractNumber,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80.w,
                child: Text(
                  'รายละเอียด',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  appointment.details,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Date and Time Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F3FB), // Light blue container
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/icons/ic_calendar.png',
                  width: 16.w,
                  height: 16.h,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    appointment.date,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF009ADB),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  appointment.time,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
