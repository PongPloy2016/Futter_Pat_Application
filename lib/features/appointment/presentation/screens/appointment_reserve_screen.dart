import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pat_application/features/appointment/widgets/appointment_reserve_widgets.dart';
import 'package:flutter_pat_application/features/appointment/widgets/appointment_widget.dart';
import 'package:flutter_pat_application/shared/widgets/appbar/custom_title_customer_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/Appointment_entity.dart';
import '../../widgets/appointment_calendar.dart';

class AppointmentReserveScreen extends StatefulWidget {
  const AppointmentReserveScreen({super.key, this.contract});

  final AppointmentEntity? contract;

  @override
  State<AppointmentReserveScreen> createState() =>
      _AppointmentReserveScreenState();
}

class _AppointmentReserveScreenState extends State<AppointmentReserveScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _displayedMonth = DateTime.now();
  String? _selectedTime;

  static const AppointmentEntity _mockContract = AppointmentEntity(
    contractId: '2101/2569',
    contractName: 'สัญญาเช่าพื้นที่สำนักงาน',
    startDate: '1 มกราคม 2569',
    endDate: '31 ธันวาคม 2570',
    monthlyRent: '25,000',
    dueDate: '31 ธันวาคม 2570',
    status: AppointmentStatus.pending,
  );

  static const List<String> _timeSlots = [
    '08.30',
    '09.00',
    '09.30',
    '10.00',
    '10.30',
    '11.00',
    '11.30',
    '13.00',
    '13.30',
    '14.00',
    '14.30',
    '15.00',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contract = widget.contract ?? _mockContract;

    return Scaffold(
      appBar: CustomtitleCustomerAppBar(
        title: 'นัดหมาย',
        onSuccess: () {
          print("Test nav  communication ");
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
              // const AppointmentReserveHeader(),
              SizedBox(height: 26.h),
              const AppointmentReserveTitle(),
              SizedBox(height: 10.h),
              AppointmentContractSummaryCard(contract: contract),
              SizedBox(height: 24.h),
              const AppointmentSectionTitle('เลือกวันนัดหมาย'),
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
              SizedBox(height: 14.h),
              const AppointmentSectionTitle('เลือกช่วงเวลาที่สะดวก'),
              SizedBox(height: 10.h),
              AppointmentTimeSlotGrid(
                slots: _timeSlots,
                selectedTime: _selectedTime,
                onSelected: (time) {
                  setState(() {
                    _selectedTime = time;
                  });
                },
              ),
              SizedBox(height: 12.h),
              AppointmentReserveInputField(
                controller: _phoneController,
                label: '*เบอร์โทรศัพท์',
                hintText: 'เบอร์โทรศัพท์',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              SizedBox(height: 8.h),
              AppointmentReserveInputField(
                controller: _noteController,
                label: 'หมายเหตุ',
                hintText: 'หมายเหตุ',
                maxLines: 2,
              ),
              SizedBox(height: 18.h),
              const AppointmentAttachFileButton(),
              SizedBox(height: 22.h),
              Center(
                child: AppointmentReserveSubmitButton(
                  enabled: _selectedTime != null,
                  onPressed: () => _submitReservation(contract),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReservation(AppointmentEntity contract) {
    const bookingId = '210000001';
    context.push('/appointment/confirm', extra: bookingId);
  }
}
