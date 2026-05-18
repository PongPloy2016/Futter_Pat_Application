import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pat_application/features/appointment/presentation/providers/controller/appointment_contract_list_controller.dart';
import 'package:flutter_pat_application/features/appointment/widgets/appointment_reserve_widgets.dart';
import 'package:flutter_pat_application/features/appointment/widgets/appointment_widget.dart';
import 'package:flutter_pat_application/features/appointment/widgets/document_upload_list.dart';
import 'package:flutter_pat_application/features/appointment/widgets/appointment_contract_item_list.dart';
import 'package:flutter_pat_application/shared/widgets/appbar/custom_title_customer_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../router/app_router.dart';
import '../../data/models/appointment_model.dart';
import '../../domain/entities/Appointment_entity.dart';
import '../../domain/entities/appointment_reserve_request_entity.dart';
import '../../data/models/appointment_reserve_request_model.dart';
import '../../widgets/appointment_calendar.dart';

class AppointmentReserveScreen extends ConsumerStatefulWidget {
  const AppointmentReserveScreen({super.key, this.contract, this.branchId});

  final AppointmentEntity? contract;
  final String? branchId;

  @override
  ConsumerState<AppointmentReserveScreen> createState() =>
      _AppointmentReserveScreenState();
}

class _AppointmentReserveScreenState
    extends ConsumerState<AppointmentReserveScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _displayedMonth = DateTime.now();
  String? _selectedTimeSlot; // 'morning' or 'afternoon'
  AppointmentEntity? _selectedAppointmentType;
  final Set<String> _selectedContractIds = {};

  /// Dynamic list of required/optional documents
  final List<DocumentUploadItem> _documentItems = const [
    DocumentUploadItem(title: 'อัปโหลดสำเนาบัตรประชาชน', isRequired: true),
    DocumentUploadItem(title: 'อัปโหลดสำเนาทะเบียนบ้าน', isRequired: true),
    DocumentUploadItem(title: 'ใบเสร็จรับเงินประกัน (ใช้ใบเสร็จเก่าได้)'),
    DocumentUploadItem(title: 'ใบเสร็จค่าเช่าเดือนปัจจุบัน'),
    DocumentUploadItem(title: 'เอกสารมอบอำนาจ'),
  ];

  /// Map of uploaded file paths keyed by document title
  final Map<String, String> _uploadedFilePaths = {};

  Future<void> _pickFileFor(DocumentUploadItem item) async {
    try {
      final result = await FilePicker.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'pdf', 'doc'],
      );
      if (result != null &&
          result.files.isNotEmpty &&
          result.files.first.path != null) {
        setState(() {
          _uploadedFilePaths[item.title] = result.files.first.path!;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'ไม่สามารถเลือกไฟล์ได้: $e');
    }
  }

  Future<void> _deleteFileFor(DocumentUploadItem item) async {
    try {
      setState(() {
        _uploadedFilePaths.remove(item.title);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'ไม่สามารถลบไฟล์ได้: $e');
    }
  }

  bool get _isFormValid {
    if (_selectedTimeSlot == null) return false;
    // Check all required documents are uploaded
    for (final item in _documentItems) {
      if (item.isRequired && !_uploadedFilePaths.containsKey(item.title)) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contract = widget.contract;
    final listState = ref.watch(appointmentContractListProvider);

    return Scaffold(
      appBar: CustomtitleCustomerAppBar(
        title: 'นัดหมายต่อสัญญา',
        onSuccess: () {
          context.pushNamed('communication');
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // 1. ประเภทนัดหมาย
              _buildAppointmentTypeSection(listState.appointments),
              SizedBox(height: 20.h),

              // 2. เลือกรายการ
              AppointmentContractItemList(
                contracts: listState.appointments,
                selectedAppointmentType: _selectedAppointmentType,
                selectedContractIds: _selectedContractIds,
                onChanged: (newIds) {
                  setState(() {
                    _selectedContractIds.clear();
                    _selectedContractIds.addAll(newIds);
                  });
                },
              ),
              SizedBox(height: 20.h),

              // 3. รายละเอียด
              _buildSectionLabel('รายละเอียด'),
              SizedBox(height: 8.h),
              AppointmentReserveInputField(
                controller: _noteController,
                label: 'รายละเอียด',
                hintText: 'ระบุรายละเอียด',
                maxLines: 2,
              ),
              SizedBox(height: 20.h),

              // 4. เบอร์ที่ใช้ในการทำสัญญา
              _buildSectionLabel('เบอร์ที่ใช้ในการทำสัญญา'),
              SizedBox(height: 8.h),
              AppointmentReserveInputField(
                controller: _phoneController,
                label: 'เบอร์ที่ใช้ในการทำสัญญา',
                hintText: 'xxx-xxx-xxxx',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              SizedBox(height: 20.h),

              // 5. วันที่นัดหมาย
              _buildSectionLabelRequired('วันที่นัดหมาย'),
              SizedBox(height: 12.h),
              AppointmentCalendar(
                selectedDate: _selectedDate,
                displayedMonth: _displayedMonth,
                onMonthChanged: (month) {
                  setState(() {
                    _displayedMonth = month;
                  });
                },
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                    _displayedMonth = DateTime(date.year, date.month);
                    Fluttertoast.showToast(
                      msg:
                          'เลือกวันที่ ${DateFormat('d MMMM yyyy', 'th').format(date)}',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                },
              ),
              SizedBox(height: 20.h),

              // 6. เวลาที่นัดหมาย
              _buildSectionLabelRequired('เวลาที่นัดหมาย'),
              SizedBox(height: 10.h),
              _buildTimePeriodSection(),
              SizedBox(height: 20.h),

              //  AppointmentAttachFileButton(
              //   onTap: () async {
              //     final result = await context.pushNamed<List<PlatformFile>>(
              //       AppRouter.attachFileDocuments,
              //     );
              //     if (result != null && result.isNotEmpty) {
              //       for (var file in result) {
              //         print("appointmentDocument file name : ${file.name}");
              //       }
              //     }
              //   },

              // 7. แนบเอกสารที่เกี่ยวข้อง (Dynamic)
              _buildSectionLabelRequired('แนบเอกสารที่เกี่ยวข้อง'),
              SizedBox(height: 16.h),
              DocumentUploadList(
                items: _documentItems,
                uploadedFiles: _uploadedFilePaths,
                onUpload: _pickFileFor,
                onDelete: _deleteFileFor,
              ),
              SizedBox(height: 12.h),

              // 8. ปุ่มบันทึก
              AppointmentReserveSubmitButton(
                enabled: true,
                onPressed: () {
                  _uploadedFilePaths.forEach((key, value) {
                    print("_uploadedFilePaths key : $key");
                    print("_uploadedFilePaths value : $value");
                  });

                  _showConfirmDialog();
                  // _submitReservation(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper label builders ---
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111111),
      ),
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

  // --- เวลาที่นัดหมาย (ช่วงเช้า/บ่าย) ---
  Widget _buildTimePeriodSection() {
    const morningQueue = 5;
    const afternoonQueue = 10;

    return Column(
      children: [
        _buildTimePeriodTile(
          label: 'ช่วงเช้า (08:30 - 11:00)',
          queueText: 'คงเหลือ $morningQueue คิว',
          value: 'morning',
        ),
        SizedBox(height: 10.h),
        _buildTimePeriodTile(
          label: 'ช่วงบ่าย (13:00 - 15:00)',
          queueText: 'คงเหลือ $afternoonQueue คิว',
          value: 'afternoon',
        ),
      ],
    );
  }

  Widget _buildTimePeriodTile({
    required String label,
    required String queueText,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeSlot = value;
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: Radio<String>(
              value: value,
              groupValue: _selectedTimeSlot,
              activeColor: appointmentPrimaryBlue,
              onChanged: (val) {
                setState(() {
                  _selectedTimeSlot = val;
                });
              },
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  color: const Color(0xFF111111),
                ),
                children: [
                  TextSpan(text: label),
                  TextSpan(
                    text: '  $queueText',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 13.sp,
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    final dateStr = DateFormat('dd/MM/yyyy').format(_selectedDate);
    final timeStr = _selectedTimeSlot == 'morning'
        ? 'ช่วงเช้า (08:30 - 11:00)'
        : 'ช่วงบ่าย (13:30 - 16:30)';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF009ADB),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFF009ADB),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),

              // Title
              Text(
                'ยืนยันการนัดหมาย',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF333333),
                ),
              ),
              SizedBox(height: 12.h),

              // Details
              Text(
                'นัดหมายวันที่ $dateStr',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 15.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                timeStr,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 15.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 24.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _submitReservation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009ADB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'บันทึกการนัดหมาย',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'แก้ไข',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
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

  void _submitReservation() {
    final req = AppointmentReserveRequestModel(
      branchId: widget.branchId,
      appointmentType: _selectedAppointmentType,
      startDate: _selectedDate,
      startTime: _selectedTimeSlot,
      appointmentNote: _noteController.text,
      phone: _phoneController.text,
      contractIds: _selectedContractIds.toList(),
      attachmentData: _uploadedFilePaths.entries.map((entry) {
        return AppointmentAttachmentData(
          title: entry.key,
          path: entry.value,
        );
      }).toList(),
    );

    print("Request JSON: ${req.toJson()}");
    context.pushNamed(AppRouter.appointmentConfirm, extra: req);
  }

  // --- ประเภทนัดหมาย (Dropdown) ---
  Widget _buildAppointmentTypeSection(
    List<AppointmentEntity> contracts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabelRequired('ประเภทนัดหมาย'),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFB8D8FF)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AppointmentEntity>(
              value: _selectedAppointmentType,
              isExpanded: true,
              hint: Text(
                'กรุณาเลือก',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 15.sp,
                  color: const Color(0xFFB5BED0),
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: const Color(0xFF009ADB),
                size: 24.sp,
              ),
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 15.sp,
                color: const Color(0xFF111111),
              ),
              items: contracts
                  .map(
                    (entity) => DropdownMenuItem<AppointmentEntity>(
                      value: entity,
                      child: Text(
                        'ต่อสัญญาเช่า (${entity.contractName})',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 15.sp,
                          color: const Color(0xFF111111),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  print("AppointmentTypeSection ${value?.contractId}");
                  _selectedAppointmentType = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
