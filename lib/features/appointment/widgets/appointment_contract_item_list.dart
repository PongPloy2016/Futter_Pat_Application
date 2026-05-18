import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../domain/entities/Appointment_entity.dart';
import 'appointment_widget.dart';

class AppointmentContractItemList extends StatefulWidget {
  const AppointmentContractItemList({
    super.key,
    required this.contracts,
    required this.selectedAppointmentType,
    required this.selectedContractIds,
    required this.onChanged,
  });

  final List<AppointmentEntity> contracts;
  final AppointmentEntity? selectedAppointmentType;
  final Set<String> selectedContractIds;
  final void Function(Set<String>) onChanged;

  @override
  State<AppointmentContractItemList> createState() => _AppointmentContractItemListState();
}

class _AppointmentContractItemListState extends State<AppointmentContractItemList> {
  @override
  Widget build(BuildContext context) {
    // ดึง landItems จาก contract ที่เลือกใน dropdown
    AppointmentEntity? selectedContract;
    if (widget.selectedAppointmentType != null) {
      final matches = widget.contracts.where(
        (e) => e.contractId == widget.selectedAppointmentType!.contractId,
      );
      selectedContract =
          matches.isNotEmpty ? matches.first : widget.selectedAppointmentType;
    }

    final landItems = selectedContract?.landItems ?? [];
    final allLandNos = landItems.map((item) => item.landNo).toList();
    final allSelected = allLandNos.isNotEmpty &&
        allLandNos.every((no) => widget.selectedContractIds.contains(no));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabelRequired('เลือกรายการ'),
        SizedBox(height: 10.h),
        if (selectedContract == null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'กรุณาเลือกประเภทนัดหมายก่อน',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                color: const Color(0xFFB5BED0),
              ),
            ),
          )
        else if (landItems.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'ไม่พบรายการที่ดินในสัญญานี้',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                color: const Color(0xFFB5BED0),
              ),
            ),
          )
        else
          ...landItems.map((item) {
            final isChecked = widget.selectedContractIds.contains(item.landNo);
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: appointmentPrimaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      side: const BorderSide(
                        color: Color(0xFFB8BED0),
                        width: 1.5,
                      ),
                      onChanged: (val) {
                        final newSet = Set<String>.from(widget.selectedContractIds);
                        if (val == true) {
                          newSet.add(item.landNo);
                        } else {
                          newSet.remove(item.landNo);
                        }
                        widget.onChanged(newSet);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      item.landname,
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14.sp,
                        color: const Color(0xFF111111),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        if (landItems.isNotEmpty) ...[
          SizedBox(height: 4.h),
          GestureDetector(
            onTap: () {
              final newSet = Set<String>.from(widget.selectedContractIds);
              if (allSelected) {
                newSet.removeAll(allLandNos);
              } else {
                newSet.addAll(allLandNos);
              }
              widget.onChanged(newSet);
            },
            child: Text(
              allSelected ? 'ยกเลิกทั้งหมด' : 'เลือกทั้งหมด',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                color: appointmentPrimaryBlue,
                decoration: TextDecoration.underline,
                decorationColor: appointmentPrimaryBlue,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionLabelRequired(String label) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111111),
          ),
        ),
        Text(
          ' *',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
