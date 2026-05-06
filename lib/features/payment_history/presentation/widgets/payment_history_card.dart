import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/payment_history_model.dart';
import '../../domain/entities/payment_history_entity.dart';

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({super.key, required this.paymentHistory});

  final PaymentHistoryEntity paymentHistory;

  @override
  Widget build(BuildContext context) {
    final isPending = paymentHistory.status == PaymentHistoryStatus.pending;

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFF3F7FA), Colors.white],
          stops: const [0.0, 0.5],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypeIcon(paymentHistory.type),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                paymentHistory.title,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Kanit',
                                  fontSize: 16.sp,
                                  // fontWeight: FontWeight.w600,
                                  color: const Color(0xFF333333),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                ' (${paymentHistory.month})',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Kanit',
                                  fontSize: 16.sp,
                                  // fontWeight: FontWeight.w600,
                                  color: const Color(0xFF333333),
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _buildStatusBadge(isPending),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'เลขที่เอกสาร: ${paymentHistory.invoiceNumber}',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 13.sp,
                        color: const Color(0xFF8E8E8E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey.withOpacity(0.15), thickness: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ยอดชำระ ',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 14.sp,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      Text(
                        '${paymentHistory.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} บาท',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF009ADB),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        'ครบกำหนดชำระ ',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 13.sp,
                          color: const Color(0xFF8E8E8E),
                        ),
                      ),
                      Text(
                        paymentHistory.dueDate,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _buildPayButton(context, isPending),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIcon(String type) {
    IconData iconData;
    Color color;

    switch (type) {
      case 'rent':
        iconData = Icons.home_outlined;
        color = const Color(0xFF009ADB);
        break;
      case 'water':
        iconData = Icons.water_drop_outlined;
        color = const Color(0xFF009ADB);
        break;
      case 'electricity':
        iconData = Icons.bolt_outlined;
        color = const Color(0xFF009ADB);
        break;
      case 'phone':
        iconData = Icons.phone_android_outlined;
        color = const Color(0xFF009ADB);
        break;
      default:
        iconData = Icons.description_outlined;
        color = const Color(0xFF009ADB);
    }

    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(iconData, color: color, size: 24.sp),
    );
  }

  Widget _buildStatusBadge(bool isPending) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFFFDF0D5) : const Color(0xFFDFF0D8),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isPending ? 'รอชำระ' : 'ชำระแล้ว',
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isPending ? const Color(0xFFE28B00) : const Color(0xFF3C763D),
        ),
      ),
    );
  }

  Widget _buildPayButton(BuildContext context, bool isPending) {
    if (!isPending) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009ADB).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle payment
          },
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Text(
              'ชำระเงิน',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
