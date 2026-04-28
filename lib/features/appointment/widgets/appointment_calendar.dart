import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../themes/colors.dart';
import 'appointment_widget.dart';

class AppointmentCalendar extends StatelessWidget {
  const AppointmentCalendar({
    super.key,
    required this.selectedDate,
    required this.displayedMonth,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final DateTime displayedMonth;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDateSelected;

  static const List<String> _weekDays = ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'];

  @override
  Widget build(BuildContext context) {
    final monthStart = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final firstWeekdayIndex = monthStart.weekday % 7;
    final firstCellDate = monthStart.subtract(
      Duration(days: firstWeekdayIndex),
    );
    const totalCells = 42; // 6 rows of 7 days to avoid blank gaps
    final monthText = DateFormat('MMMM yyyy', 'th').format(displayedMonth);
    final today = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appointmentPrimaryBlue, width: 1.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    final previousMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month - 1,
                    );
                    onMonthChanged(previousMonth);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 20.sp,
                      color: appointmentPrimaryBlue,
                    ),
                  ),
                ),
                Text(
                  monthText,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111111),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final nextMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month + 1,
                    );
                    onMonthChanged(nextMonth);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 20.sp,
                      color: appointmentPrimaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: appointmentPrimaryBlue,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: _weekDays
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: totalCells,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final cellDate = firstCellDate.add(Duration(days: index));
              final isCurrentMonth = cellDate.month == displayedMonth.month;
              final isSelected =
                  cellDate.year == selectedDate.year &&
                  cellDate.month == selectedDate.month &&
                  cellDate.day == selectedDate.day;
              final isToday =
                  cellDate.year == today.year &&
                  cellDate.month == today.month &&
                  cellDate.day == today.day;
              final textColor = isCurrentMonth
                  ? const Color(0xFF111111)
                  : const Color(0xFFCBCBCB);

              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: const Color(0xFFDADADA),
                      width: 0.7.w,
                    ),
                    bottom: BorderSide(
                      color: const Color(0xFFDADADA),
                      width: 0.7.w,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    onDateSelected(cellDate);
                  },
                  child: Center(
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? appointmentPrimaryBlue
                            : isToday
                            ? accent.withValues(alpha: 0.36)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                        border: isToday && !isSelected
                            ? Border.all(
                                color: appointmentPrimaryBlue,
                                width: 1.2.w,
                              )
                            : null,
                      ),
                      child: Text(
                        '${cellDate.day}',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : isToday
                              ? appointmentPrimaryBlue
                              : textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
