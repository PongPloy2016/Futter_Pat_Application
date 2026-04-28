import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../router/app_router.dart';
import '../domain/entities/Appointment_entity.dart';
import 'appointment_widget.dart';

class AppointmentReserveHeader extends StatelessWidget {
  const AppointmentReserveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppointmentBackButton(),
        Image.asset(
          'lib/assets/icons/ic_profile_mock.png',
          width: 38.w,
          height: 38.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}

class AppointmentReserveTitle extends StatelessWidget {
  const AppointmentReserveTitle({super.key});

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
        Text(
          'นัดหมายต่อสัญญา',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: appointmentPrimaryBlue,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class AppointmentContractSummaryCard extends StatelessWidget {
  const AppointmentContractSummaryCard({super.key, required this.contract});

  final AppointmentEntity contract;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withValues(alpha: 0.34),
            blurRadius: 26,
            offset: const Offset(-8, -5),
          ),
          BoxShadow(
            color: const Color(0xFFDDE1F0).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          AppointmentSummaryRow(
            label: 'เลขที่สัญญา',
            value: '${contract.contractId}\n${contract.contractName}',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(
              height: 1,
              thickness: 1,
              color: const Color(0xFFE0E0E0),
            ),
          ),
          AppointmentSummaryRow(
            label: 'วันที่สิ้นสุดสัญญา',
            value: contract.endDate,
          ),
        ],
      ),
    );
  }
}

class AppointmentSummaryRow extends StatelessWidget {
  const AppointmentSummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 106.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: appointmentLabelTextColor,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111111),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentSectionTitle extends StatelessWidget {
  const AppointmentSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF111111),
      ),
    );
  }
}


class AppointmentCalendarDayCell extends StatelessWidget {
  const AppointmentCalendarDayCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final int day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? appointmentPrimaryBlue.withValues(alpha: 0.08)
          : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: const Color(0xFFDADADA), width: 0.7.w),
              bottom: BorderSide(color: const Color(0xFFDADADA), width: 0.7.w),
            ),
          ),
          child: Center(
            child: Container(
              width: 24.w,
              height: 22.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? appointmentPrimaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '$day',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF111111),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentTimeSlotGrid extends StatelessWidget {
  const AppointmentTimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedTime,
    required this.onSelected,
  });

  final List<String> slots;
  final String? selectedTime;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      itemCount: slots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 26.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 2.65,
      ),
      itemBuilder: (context, index) {
        final time = slots[index];
        final isSelected = time == selectedTime;

        return AppointmentTimeSlotButton(
          time: time,
          isSelected: isSelected,
          onTap: () => onSelected(time),
        );
      },
    );
  }
}

class AppointmentTimeSlotButton extends StatelessWidget {
  const AppointmentTimeSlotButton({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? appointmentPrimaryBlue.withValues(alpha: 0.12)
                : Colors.white,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: isSelected
                  ? appointmentPrimaryBlue
                  : const Color(0xFFD5D5D5),
            ),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: isSelected
                  ? appointmentPrimaryBlue
                  : const Color(0xFF8F9AAB),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentReserveInputField extends StatelessWidget {
  const AppointmentReserveInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 14.sp,
        color: const Color(0xFF111111),
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: appointmentPrimaryBlue,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 13.sp,
          color: appointmentHintTextColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: Color(0xFFB8D8FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(
            color: appointmentPrimaryBlue,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class AppointmentAttachFileButton extends StatelessWidget {
  const AppointmentAttachFileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92.w,
      height: 28.h,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed(AppRouter.appointmentDocument);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF263C96),
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          'แนบไฟล์',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class AppointmentReserveSubmitButton extends StatelessWidget {
  const AppointmentReserveSubmitButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: enabled ? 1 : 0.55,
      child: SizedBox(
        width: 212.w,
        height: 38.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            gradient: const LinearGradient(
              colors: [Color(0xFF009ADB), Color(0xFF1FB4F2)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: appointmentPrimaryBlue.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
            child: Text(
              'จองคิวนัดหมาย',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
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
