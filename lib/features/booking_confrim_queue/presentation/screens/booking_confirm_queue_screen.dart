import 'package:flutter/material.dart';
import 'package:flutter_pat_application/themes/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../../../../shared/widgets/logo/logo_create_pin.dart';
import '../../../appointment/data/models/appointment_reserve_request_model.dart';
import '../providers/booking_confirm_queue_provider.dart';
import '../widgets/booking_confirm_queue_badge.dart';
import '../widgets/booking_confirm_queue_contact_footer.dart';
import '../widgets/booking_confirm_queue_info_card.dart';
import '../widgets/booking_confirm_queue_notes_section.dart';

class BookingConfirmQueueScreen extends ConsumerWidget {
  const BookingConfirmQueueScreen({super.key, required this.request});

  final AppointmentReserveRequestModel request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingConfirmQueueProvider(request));

    return bookingState.when(
      data: (booking) => Scaffold(
        appBar: CustomtitleCustomerAppBar(
          title: 'การนัดหมาย',
          onSuccess: () {
            context.pushNamed('communication');
          },
        ),
        backgroundColor: const Color(0xFFF5F7FA),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  // ── Main White Card ──
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF000000).withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white, // Lighter blue (approx #E8F6FF)
                              Colors.white, // Slightly darker (approx #E0F0FF)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF000000)
                                  .withValues(alpha: 0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ]),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          LogoCreatePinWidget(),

                          // ── 1. Queue Badge (PAT Logo + Queue Number) ──
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(primaryBlueLight),
                              width: double.infinity,
                              height: 200.h,
                              child: BookingConfirmQueueBadge(
                                queueNumber: booking.queueNumber,
                                timeLabel: booking.timeLabel,
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // ── 2. Section Title ──
                          _buildSectionTitle('รายละเอียดการนัดหมาย'),
                          SizedBox(height: 8.h),

                          // ── 3. Info Card ──
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child:
                                BookingConfirmQueueInfoCard(booking: booking),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── 4. Notes Section ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: const BookingConfirmQueueNotesSection(),
                  ),
                  SizedBox(height: 24.h),

                  // ── 5. Cancel Button (Red) ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () => _showCancelDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE53935),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor:
                              const Color(0xFFE53935).withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'ยกเลิกการนัดหมาย',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ── 6. Edit Button (Outlined Blue) ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: OutlinedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF009ADB),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'แก้ไขนัดหมาย',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF009ADB),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── 7. Contact Footer ──
                  const BookingConfirmQueueContactFooter(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
      loading: () => const Scaffold(
        backgroundColor: Color(0xFFF5F7FA),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(child: Text('เกิดข้อผิดพลาด: $error')),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF009ADB),
          ),
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: const Color(0xFFFF9800),
                  size: 36.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'ยกเลิกการนัดหมาย?',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF333333),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'คุณต้องการยกเลิกการนัดหมายนี้ใช่หรือไม่?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 24.h),

              // Confirm Cancel
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: Implement cancel booking API call
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'ยืนยันยกเลิก',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Go Back
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'กลับ',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF666666),
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
