import 'package:flutter/material.dart';
import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';
import 'package:flutter_pat_application/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../providers/receipt_tax_invoice_provider.dart';
import '../widgets/receipt_tax_invoice_header.dart';
import '../widgets/receipt_tax_invoice_info_card.dart';
import '../widgets/receipt_tax_invoice_dropdown.dart';
import '../widgets/receipt_tax_invoice_date_picker.dart';

class ReceiptTaxInvoiceScreen extends ConsumerStatefulWidget {
  const ReceiptTaxInvoiceScreen({super.key});

  @override
  ConsumerState<ReceiptTaxInvoiceScreen> createState() =>
      _ReceiptTaxInvoiceScreenState();
}

class _ReceiptTaxInvoiceScreenState
    extends ConsumerState<ReceiptTaxInvoiceScreen> {
  TaxInvoiceModel? _selectedType;
  final TextEditingController _monthYearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูล Dropdown เมื่อเปิดหน้าจอ
    Future.microtask(
      () => ref.read(receiptTaxInvoiceProvider.notifier).fetchExpenseTypes(),
    );
  }

  @override
  void dispose() {
    _monthYearController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_selectedType == null || _monthYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
      return;
    }

    // เรียกฟังก์ชันส่งคำขอ
    ref
        .read(receiptTaxInvoiceProvider.notifier)
        .submitRequest(_selectedType!.id, _monthYearController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(receiptTaxInvoiceProvider);

    // Listen for success
    ref.listen(receiptTaxInvoiceProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ส่งคำขอสำเร็จแล้ว')));
        context.pushNamed(AppRouter.receiptTaxInvoiceDetail);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${next.error}')),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: CustomtitleCustomerAppBar(
        title: '',
        onSuccess: () => context.pop(),
        showActions: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const ReceiptTaxInvoiceHeader(title: 'ใบเสร็จ / ใบกำกับภาษี'),
              SizedBox(height: 24.h),

              // Top Information Card
              const ReceiptTaxInvoiceInfoCard(
                imagePath: 'lib/assets/images/ic_receiptTaxInvoice_file.png',
                title: 'ขอใบเสร็จ / ใบกำกับภาษี',
                description:
                    'กรุณาเลือกประเภทและเลือกเดือนของใบเสร็จ/ใบกำกับภาษีที่ต้องการขอ',
              ),

              SizedBox(height: 24.h),

              // Form Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB8BED9).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('ประเภทรายการ*'),
                    ReceiptTaxInvoiceDropdown(
                      items: state.expenseTypes,
                      value: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    _buildLabel('เดือน/ปี*'),
                    ReceiptTaxInvoiceDatePicker(
                      text: _monthYearController.text,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            _monthYearController.text =
                                "${picked.month}/${picked.year}";
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009ADB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF009ADB).withOpacity(0.4),
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'ขอใบเสร็จ / ใบกำกับภาษี',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF009ADB),
        ),
      ),
    );
  }
}
