import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/app_router.dart';
import '../widgets/contract_card.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key});

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  int _selectedTab = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScanned(String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ข้อมูลที่สแกนได้:\n$data',
          style: const TextStyle(fontFamily: 'Kanit'),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: contractPrimaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              const ContractBackButton(),
              SizedBox(height: 28.h),
              const ContractPageTitle(title: 'เพิ่มข้อมูลสัญญา'),
              SizedBox(height: 28.h),
              _ContractTabBar(
                selectedIndex: _selectedTab,
                labels: const ['Barcode', 'QR Code', 'หมายเลขอ้างอิง'],
                onChanged: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              SizedBox(height: 40.h),
              SizedBox(
                height: 230.h,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  children: [
                    _ScanContractCard(
                      label: 'Scan Barcode',
                      isBarcode: true,
                      onScanned: _onScanned,
                    ),
                    _ScanContractCard(
                      label: 'Scan QR Code',
                      isBarcode: false,
                      onScanned: _onScanned,
                    ),
                    const _ReferenceNumberCard(),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              const _ContractRemark(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContractTabBar extends StatelessWidget {
  const _ContractTabBar({
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
  });

  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      decoration: BoxDecoration(
        color: contractPrimaryBlue,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? contractDarkBlue : contractPrimaryBlue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  labels[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ScanContractCard extends StatelessWidget {
  const _ScanContractCard({
    required this.label,
    required this.isBarcode,
    required this.onScanned,
  });

  final String label;
  final bool isBarcode;
  final ValueChanged<String> onScanned;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124.h,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
      child: Center(
        child: ContractPrimaryButton(
          label: label,
          width: 172,
          backgroundColor: contractDarkBlue,
          onPressed: () async {
            final result = await context.pushNamed<String>(
              AppRouter.scanContract,
              extra: isBarcode,
            );
            if (result != null && result.isNotEmpty) {
              onScanned(result);
            }
          },
        ),
      ),
    );
  }
}

class _ReferenceNumberCard extends StatelessWidget {
  const _ReferenceNumberCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
        children: [
          const _ReferenceInputRow(label: 'Ref 1 :'),
          SizedBox(height: 12.h),
          const _ReferenceInputRow(label: 'Ref 2 :'),
          SizedBox(height: 32.h),
          ContractPrimaryButton(
            label: 'ยอมรับ',
            width: 132,
            backgroundColor: contractDarkBlue,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ReferenceInputRow extends StatelessWidget {
  const _ReferenceInputRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 66.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 32.h,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFEAF4F6),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF008DFF)),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF008DFF), width: 1.4),
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContractRemark extends StatelessWidget {
  const _ContractRemark();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'หมายเหตุ',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            color: const Color(0xFFE41E2B),
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFFE41E2B),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Ref 1 คือ รหัสลูกค้า\n'
          'Ref 2 คือ รหัสทรัพย์สิน\n'
          'ต้องการเพิ่มสัญญา กรุณาติดต่อ\n'
          'แผนกระเบียนและสัญญา เบอร์โทร : 02-269-5354 ต่อ 55\n'
          'แผนกการเงิน เบอร์โทร : 02-269-5320 ต่อ 21\n'
          'ในช่วงเวลา 09.00 - 16.00 น.',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            height: 1.45,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
