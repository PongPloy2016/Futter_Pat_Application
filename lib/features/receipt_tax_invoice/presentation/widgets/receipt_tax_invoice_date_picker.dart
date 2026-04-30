import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptTaxInvoiceDatePicker extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String hint;

  const ReceiptTaxInvoiceDatePicker({
    super.key,
    required this.text,
    required this.onTap,
    this.hint = 'เดือน/ปี',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text.isEmpty ? hint : text,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  color: text.isEmpty
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF222222),
                ),
              ),
            ),
            const Icon(Icons.calendar_month_outlined, color: Color(0xFF009ADB)),
          ],
        ),
      ),
    );
  }
}
