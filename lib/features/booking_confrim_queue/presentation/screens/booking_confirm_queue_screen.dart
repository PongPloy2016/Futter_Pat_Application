import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: const Color(0xFFF8F9FB),
        body: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(28.w, 18.h, 28.w, 112.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: const BookingConfirmQueueHeader()),
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
              Center(
                child: BookingConfirmQueueConfirmButton(
                  onPressed: () => _showConfirmDialog(context),
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
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการจอง'),
        content: const Text('คุณต้องการยืนยันการนัดหมายใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ยืนยันการนัดหมายเรียบร้อยแล้ว')),
              );
            },
            child: const Text('ยืนยัน'),
          ),
        ],
      ),
    );
  }
}
