import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../../domain/entities/payment_history_entity.dart';
import '../providers/payment_history_provider.dart';
import '../widgets/payment_history_card.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  ConsumerState<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends ConsumerState<PaymentHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(invoiceProvider);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        appBar: CustomtitleCustomerAppBar(
          title: '',
          onSuccess: () {
            context.pop();
          },
          showActions: false,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF009ADB),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'ประวัติการชำระเงิน',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF009ADB),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _buildTabBar(),
                  ],
                ),
              ),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.error != null
                    ? Center(child: Text('Error: ${state.error}'))
                    : TabBarView(
                        children: [
                          _buildListView(state.filteredInvoices),
                          _buildListView(state.rentInvoices),
                          _buildListView(state.waterInvoices),
                          _buildListView(state.electricityInvoices),
                          _buildListView(state.phoneInvoices),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF009ADB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.r),
      child: TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: const Color(0xFF003D6B), // Darker blue for active tab
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF003D6B).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'ทั้งหมด'),
          Tab(text: 'ค่าเช่า'),
          Tab(text: 'ค่าน้ำ'),
          Tab(text: 'ค่าไฟ'),
          Tab(text: 'ค่าโทรศัพท์'),
        ],
      ),
    );
  }

  Widget _buildListView(List<PaymentHistoryEntity> invoices) {
    if (invoices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            Text(
              'ไม่พบข้อมูลประวัติการชำระเงิน',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return PaymentHistoryCard(paymentHistory: invoices[index]);
      },
    );
  }
}
