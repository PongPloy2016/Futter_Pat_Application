import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/contract_entity.dart';

const Color contractPrimaryBlue = Color(0xFF009ADB);
const Color contractDarkBlue = Color(0xFF004B93);
const Color contractLabelTextColor = Color(0xFF6B6B6B);

class ContractBackButton extends StatelessWidget {
  const ContractBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: contractPrimaryBlue, width: 1.5),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: contractPrimaryBlue,
          size: 24.sp,
        ),
      ),
    );
  }
}

class ContractPageTitle extends StatelessWidget {
  const ContractPageTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: contractPrimaryBlue,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: contractPrimaryBlue,
          ),
        ),
      ],
    );
  }
}

class ContractPrimaryButton extends StatelessWidget {
  const ContractPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.backgroundColor = contractPrimaryBlue,
  });

  final String label;
  final VoidCallback onPressed;
  final double? width;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 38.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ContractCard extends StatelessWidget {
  const ContractCard({super.key, required this.contract, this.onPay});

  final ContractEntity contract;
  final VoidCallback? onPay;

  @override
  Widget build(BuildContext context) {
    final isPaid = contract.status == ContractStatus.paid;

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 14.w, 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFF2F4FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withValues(alpha: 0.32),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 18,
            offset: const Offset(-6, -6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ข้อมูลสัญญา',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF222222),
                ),
              ),
              const Spacer(),
              _StatusBadge(status: contract.status),
            ],
          ),
          const _ContractDivider(),
          _InfoRow(label: 'เลขที่สัญญา', value: contract.contractId),
          SizedBox(height: 8.h),
          _InfoRow(label: 'ชื่อสัญญา', value: contract.contractName),
          const _ContractDivider(),
          _InfoRow(label: 'วันที่เริ่มต้นสัญญา', value: contract.startDate),
          SizedBox(height: 8.h),
          _InfoRow(label: 'วันที่สิ้นสุดสัญญา', value: contract.endDate),
          const _ContractDivider(),
          _InfoRow(
            label: 'ค่าเช่า/เดือน',
            value: '${contract.monthlyRent} บาท',
          ),
          SizedBox(height: 8.h),
          _InfoRow(
            label: 'กำหนดชำระเงิน',
            value: contract.dueDate,
            valueColor: contractPrimaryBlue,
          ),
          if (!isPaid && onPay != null) ...[
            SizedBox(height: 22.h),
            Center(
              child: ContractPrimaryButton(
                label: 'ชำระเงิน',
                // width: 100,
                onPressed: onPay!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContractDivider extends StatelessWidget {
  const _ContractDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(height: 1.h, thickness: 1, color: const Color(0xFFE3E3E3)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor = const Color(0xFF222222),
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 114.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: contractLabelTextColor,
              height: 1.25,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: valueColor,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ContractStatus status;

  @override
  Widget build(BuildContext context) {
    final isPaid = status == ContractStatus.paid;

    return Container(
      constraints: BoxConstraints(minWidth: 68.w),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0xFFDDF6DB) : const Color(0xFFFFF4D8),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        isPaid ? 'ชำระแล้ว' : 'รอชำระ',
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: isPaid ? const Color(0xFF178A24) : const Color(0xFFE3A100),
        ),
      ),
    );
  }
}
