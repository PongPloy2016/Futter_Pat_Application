import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/button/button_customs.dart';
import '../../widgets/appointment_widget.dart';
import '../providers/controller/appointment_contract_list_controller.dart';
import '../providers/state/appointment_contract_list_state.dart';

class AppointmentListSeleteScreen extends ConsumerStatefulWidget {
  const AppointmentListSeleteScreen({super.key});

  @override
  ConsumerState<AppointmentListSeleteScreen> createState() =>
      _AppointmentListSeleteScreenState();
}

class _AppointmentListSeleteScreenState
    extends ConsumerState<AppointmentListSeleteScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ref
        .read(appointmentContractListProvider.notifier)
        .setSearchQuery(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentContractListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        bottom: 20.h,
        left: 24.w,
        right: 24.w,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF009ADB),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.r),
          bottomRight: Radius.circular(0.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for profile/back if needed, but image shows centered title
              SizedBox(width: 40.w),
              Text(
                'การนัดหมาย',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.notifications_none_rounded,
                      color: Colors.white, size: 28.sp),
                  SizedBox(width: 12.w),
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'อ',
                        style: TextStyle(
                          color: const Color(0xFF009ADB),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AppointmentContractListState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(
          'ไม่สามารถโหลดข้อมูลสัญญาได้',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16.sp,
            color: Colors.red.shade400,
          ),
        ),
      );
    }

    final contracts = state.filteredAppointments;

    if (contracts.isEmpty) {
      return AppointmentEmptyState(
        onAddPressed: () {
          // Navigate to add appointment flow
          context.push('/appointment/reserve');
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          AppointmentSearchField(controller: _searchController),
          SizedBox(height: 18.h),
          Text(
            'รายการสัญญาที่สามารถดำเนินการต่ออายุได้',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: appointmentLabelTextColor,
            ),
          ),
          SizedBox(height: 14.h),
          Expanded(
            child: _buildContractList(state),
          ),
          Center(
            child: PrimarySubmitsButton(
              width: double.infinity,
              text: "เพิ่มการนัดหมาย",
              onPressed: () {
                context.push(
                  '/appointment/reserve',
                  extra: state.selectedContract,
                );
                // if (state.selectedContract != null) {
                //   context.push(
                //     '/appointment/reserve',
                //     extra: state.selectedContract,
                //   );
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text(
                //         'กรุณาเลือกสัญญาก่อนดำเนินการต่ออายุ',
                //         style: TextStyle(fontFamily: 'Kanit'),
                //       ),
                //       behavior: SnackBarBehavior.floating,
                //       backgroundColor: Colors.redAccent,
                //     ),
                //   );
                // }
              },
            ),
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }

  Widget _buildContractList(AppointmentContractListState state) {
    final contracts = state.filteredAppointments;

    if (contracts.isEmpty) {
      return const AppointmentEmptyState();
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 24.h),
      itemCount: contracts.length,
      separatorBuilder: (_, __) => SizedBox(height: 18.h),
      itemBuilder: (context, index) {
        final contract = contracts[index];
        return AppointmentContractCard(
          contract: contract,
          //isSelected: contract.contractId == state.selectedContractId,
          onTap: () {
            ref
                .read(appointmentContractListProvider.notifier)
                .selectContract(contract);
          },
        );
      },
    );
  }
}
