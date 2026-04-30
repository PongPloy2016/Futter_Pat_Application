import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';

class ReceiptTaxInvoiceDetailScreen extends StatelessWidget {
  const ReceiptTaxInvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: CustomtitleCustomerAppBar(
        title: '',
        onSuccess: () => context.pop(),
        showActions: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildHeaderTitle(),
                    SizedBox(height: 24.h),
                    _buildMainCard(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: const Color(0xFF009ADB),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'ใบเสร็จ / ใบกำกับภาษี',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF009ADB),
          ),
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Text(
                  'ใบเสร็จค่าเช่า',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'เลขที่เอกสาร : INV-2026-0001  ออกวันที่ 11 กุมภาพันธ์ 2569',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 12.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFF1F5F9), thickness: 1),
                SizedBox(height: 16.h),
                
                // Customer Info Section
                _buildInfoSection(
                  color: const Color(0xFFEBF6FF),
                  children: [
                    _buildInfoRow('รหัสลูกหนี้', '2101/2569'),
                    _buildInfoRow('ชื่อ-นามสกุล', 'นายสมใจ ใจดี'),
                    _buildInfoRow('ที่อยู่', '476/97 หมู่ 8 ต.ในเมือง เมืองราชบุรี\nราชบุรี 74557'),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // Payment Info Section
                _buildInfoSection(
                  color: const Color(0xFFEBF6FF),
                  children: [
                    _buildInfoRow('ทรัพย์สิน', 'A-101 แปลง 12'),
                    _buildInfoRow('รอบบิล', 'มกราคม 2569'),
                    _buildInfoRow('วันที่ชำระ', '10 กุมภาพันธ์ 2569'),
                    _buildInfoRow('ค่าเช่า', '15,000 บาท'),
                    _buildInfoRow('ค่าปรับ', '150 บาท'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({required Color color, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                color: const Color(0xFF666666),
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
                color: const Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.share_outlined,
              label: 'แชร์',
              onPressed: () {},
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildActionButton(
              icon: Icons.file_download_outlined,
              label: 'ดาวน์โหลด PDF',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF009ADB),
        elevation: 4,
        shadowColor: const Color(0xFFB8BED9).withOpacity(0.3),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
