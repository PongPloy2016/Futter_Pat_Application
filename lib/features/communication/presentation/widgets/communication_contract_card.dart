import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CommunicationContractCard extends StatelessWidget {
  const CommunicationContractCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEBE9F6),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContractRow('เลขที่สัญญา', '2101/2569'),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110.w,
                child: Text(
                  'ชื่อสัญญา',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 14.sp,
                    color: const Color(0xFF6B6B6B),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'สัญญาเช่าพื้นที่สำนักงาน',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.pushNamed('contractList'),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: const Color(0xFF009ADB)),
                  ),
                  child: Text(
                    'ดูรายละเอียด',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 12.sp,
                      color: const Color(0xFF009ADB),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildContractRow('วันที่สิ้นสุดสัญญา', '31 ธันวาคม 2570'),
        ],
      ),
    );
  }

  Widget _buildContractRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: const Color(0xFF6B6B6B),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
