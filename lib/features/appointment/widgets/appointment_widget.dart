import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../domain/entities/Appointment_entity.dart';

const Color appointmentPrimaryBlue = Color(0xFF009ADB);
const Color appointmentHintTextColor = Color(0xFFB5BED0);
const Color appointmentLabelTextColor = Color(0xFF6B6B6B);

class AppointmentBackButton extends StatelessWidget {
  const AppointmentBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: appointmentPrimaryBlue, width: 1.5),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: appointmentPrimaryBlue,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}

class AppointmentTitle extends StatelessWidget {
  const AppointmentTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: appointmentPrimaryBlue,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'เลือกสัญญาเพื่อต่ออายุสัญญา',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: appointmentPrimaryBlue,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentSearchField extends StatelessWidget {
  const AppointmentSearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 16.sp,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: 'ค้นหาสัญญา',
          hintStyle: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            color: appointmentHintTextColor,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 10.h,
          ),
          suffixIcon: Icon(
            Icons.search_rounded,
            color: appointmentPrimaryBlue,
            size: 28.sp,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFFBCD9F4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: appointmentPrimaryBlue,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentEmptyState extends StatelessWidget {
  const AppointmentEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Text(
          'ไม่พบรายการสัญญาที่ตรงกับคำค้นหา',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            color: appointmentLabelTextColor,
          ),
        ),
      ),
    );
  }
}

class AppointmentSubmitButton extends StatelessWidget {
  const AppointmentSubmitButton({super.key, required this.selectedContract});

  final AppointmentEntity? selectedContract;

  @override
  Widget build(BuildContext context) {
    final isEnabled = selectedContract != null;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isEnabled ? 1 : 0.55,
      child: SizedBox(
        width: 118.w,
        height: 44.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            gradient: const LinearGradient(
              colors: [Color(0xFF009ADB), Color(0xFF1FB4F2)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: appointmentPrimaryBlue.withValues(alpha: 0.24),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isEnabled
                ? () => context.push(
                    '/appointment/reserve',
                    extra: selectedContract,
                  )
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'ต่อสัญญา',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentContractCard extends StatelessWidget {
  const AppointmentContractCard({
    super.key,
    required this.contract,
    required this.isSelected,
    required this.onTap,
  });

  final AppointmentEntity contract;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: isSelected
                  ? appointmentPrimaryBlue
                  : const Color(0xFFF2F4FF),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB8BED9).withValues(alpha: 0.28),
                blurRadius: 26,
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
            children: [
              _buildInfoRow('เลขที่สัญญา', contract.contractId),
              SizedBox(height: 8.h),
              _buildInfoRow('ชื่อสัญญา', contract.contractName),
              SizedBox(height: 8.h),
              _buildInfoRow('วันสิ้นสุดสัญญา', contract.endDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 108.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 15.sp,
              color: const Color(0xFF666666),
              height: 1.25,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}
