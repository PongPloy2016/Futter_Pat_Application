import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/TaxInvoice_model.dart';

class ReceiptTaxInvoiceDropdown extends StatelessWidget {
  final List<TaxInvoiceModel> items;
  final TaxInvoiceModel? value;
  final ValueChanged<TaxInvoiceModel?> onChanged;
  final String hint;

  const ReceiptTaxInvoiceDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint = 'ประเภทรายการ',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TaxInvoiceModel>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF009ADB)),
          items: items.map((TaxInvoiceModel type) {
            return DropdownMenuItem<TaxInvoiceModel>(
              value: type,
              child: Text(
                type.name,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  color: const Color(0xFF222222),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
