import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../../../../shared/widgets/button/button_customs.dart';
import '../../domain/entities/check_appointment_entity.dart';
import '../providers/check_appointments_provider.dart';
import '../widgets/check_appointment_card.dart';

class CheckAppointmentsScreen extends ConsumerStatefulWidget {
  const CheckAppointmentsScreen({super.key});

  @override
  ConsumerState<CheckAppointmentsScreen> createState() =>
      _CheckAppointmentsScreenState();
}

class _CheckAppointmentsScreenState
    extends ConsumerState<CheckAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkAppointmentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: CustomtitleCustomerAppBar(
        title: '',
        onSuccess: () {
          // CustomtitleCustomerAppBar typically handles its own back button or user actions.
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
                        'ตรวจสอบการนัดหมาย',
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
                  _buildSearchBar(),
                  SizedBox(height: 16.h),
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
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildListView(state.allFiltered),
                        _buildListView(state.pendingFiltered),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: PrimarySubmitsButton(
                  text: "นัดหมาย",
                  width: 200.w,
                  height: 50.h,
                  onPressed: () {
                    // Navigate to appointment renewal
                    context.pushNamed('appointmentRenewal');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFD6E4F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          ref.read(checkAppointmentsProvider.notifier).search(value);
        },
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          color: const Color(0xFF222222),
        ),
        decoration: InputDecoration(
          hintText: 'ค้นหาสัญญา',
          hintStyle: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          suffixIcon: Icon(
            Icons.search,
            color: const Color(0xFF009ADB),
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: const Color(0xFF009ADB),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009ADB).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.r),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: const Color(0xFF003D6B),
          borderRadius: BorderRadius.circular(8.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        overlayColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.transparent;
        }),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Kanit',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'ทั้งหมด'),
          Tab(text: 'รอดำเนินการ'),
        ],
      ),
    );
  }

  Widget _buildListView(List<CheckAppointmentEntity> appointments) {
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'ไม่พบข้อมูล',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return CheckAppointmentCard(appointment: appointments[index]);
      },
    );
  }
}
