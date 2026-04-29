import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/button/button_customs.dart';
import '../../domain/entities/Appointment_entity.dart';
import '../../widgets/appointment_widget.dart';
import '../providers/appointment_contract_provider.dart';

class AppointmentListSeleteScreen extends ConsumerStatefulWidget {
  const AppointmentListSeleteScreen({super.key});

  @override
  ConsumerState<AppointmentListSeleteScreen> createState() =>
      _AppointmentListSeleteScreenState();
}

class _AppointmentListSeleteScreenState
    extends ConsumerState<AppointmentListSeleteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedContractId;
  AppointmentEntity? _selectedContract;

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
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contractState = ref.watch(appointmentContractListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              const AppointmentBackButton(),
              SizedBox(height: 28.h),
              const AppointmentTitle(),
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
                child: contractState.when(
                  data: _buildContractList,
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Text(
                      'ไม่สามารถโหลดข้อมูลสัญญาได้',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16.sp,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: PrimarySubmitsButton(
                  text: "ต่อสัญญา",
                  onPressed: () {
                    if (_selectedContract != null) {
                      context.push(
                        '/appointment/reserve',
                        extra: _selectedContract,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'กรุณาเลือกสัญญาก่อนดำเนินการต่ออายุ',
                            style: TextStyle(fontFamily: 'Kanit'),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContractList(List<AppointmentEntity> contracts) {
    final filteredContracts = _filterContracts(contracts);

    if (filteredContracts.isEmpty) {
      return const AppointmentEmptyState();
    }

    if (!filteredContracts.any(
      (contract) => () {
        if (_selectedContractId == null) return true;
        return contract.contractId == _selectedContractId;
      }(),
    )) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedContractId = null;
            _selectedContract = null;
          });
        }
      });
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 24.h),
      itemCount: filteredContracts.length,
      separatorBuilder: (_, __) => SizedBox(height: 18.h),
      itemBuilder: (context, index) {
        final contract = filteredContracts[index];
        return AppointmentContractCard(
          contract: contract,
          isSelected: contract.contractId == _selectedContractId,
          onTap: () {
            setState(() {
              _selectedContractId = contract.contractId;
              _selectedContract = contract;
            });
          },
        );
      },
    );
  }

  List<AppointmentEntity> _filterContracts(List<AppointmentEntity> contracts) {
    if (_searchQuery.isEmpty) {
      return contracts;
    }

    return contracts.where((contract) {
      final searchableText = '${contract.contractId} ${contract.contractName}'
          .toLowerCase();
      return searchableText.contains(_searchQuery);
    }).toList();
  }
}
