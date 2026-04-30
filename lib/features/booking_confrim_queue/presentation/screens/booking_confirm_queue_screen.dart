import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../../../../shared/widgets/button/button_customs.dart';
import '../providers/booking_confirm_queue_provider.dart';
import '../widgets/booking_confirm_queue_badge.dart';
import '../widgets/booking_confirm_queue_confirm_button.dart';
import '../widgets/booking_confirm_queue_header.dart';
import '../widgets/booking_confirm_queue_info_card.dart';
import '../widgets/booking_confirm_queue_title.dart';

class BookingConfirmQueueScreen extends ConsumerWidget {
  const BookingConfirmQueueScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingConfirmQueueProvider(bookingId));

    return bookingState.when(
      data: (booking) => Scaffold(
        appBar: CustomtitleCustomerAppBar(
          title: '',
          onSuccess: () {
            print("Test nav  communication ");
            context.pushNamed('communication');
          },
        ),
        backgroundColor: const Color(0xFFF8F9FB),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(28.w, 18.h, 28.w, 112.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(child: const BookingConfirmQueueHeader()),
                      SizedBox(height: 28.h),
                      const BookingConfirmQueueTitle(),
                      SizedBox(height: 26.h),
                      Center(
                        child: BookingConfirmQueueBadge(
                          queueNumber: booking.queueNumber,
                          timeLabel: booking.timeLabel,
                        ),
                      ),
                      SizedBox(height: 36.h),
                      BookingConfirmQueueInfoCard(booking: booking),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: PrimarySubmitsButton(
                    text: "ยืนยันการนัดหมาย",
                    width: 200.w,
                    height: 50.h,
                    onPressed: () {
                      print("Test nav  communication ");
                      _showConfirmDialog(context);
                    },
                  ),

                  // BookingConfirmQueueConfirmButton(
                  //   onPressed: () => _showConfirmDialog(context),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('เกิดข้อผิดพลาด: $error'))),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F7ED),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF42B83F),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 40.w),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'นัดหมาย เสร็จสิ้น',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                ),
              ),
              SizedBox(height: 16.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '*หมายเหตุ : ',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 12.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'ผู้เช่าต้องนำเอกสารฉบับจริงมาในวันต่อสัญญา',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 120.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // สามารถเพิ่ม context.goNamed(...) เพื่อกลับไปหน้าแรกได้ถ้าต้องการ
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'เสร็จ',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
