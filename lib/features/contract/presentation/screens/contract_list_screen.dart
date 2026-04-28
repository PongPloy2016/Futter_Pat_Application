import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/app_router.dart';
import '../../../../router/extras/payment_extra.dart';
import '../providers/contract_provider.dart';
import '../widgets/contract_card.dart';

class ContractListScreen extends ConsumerWidget {
  const ContractListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractState = ref.watch(contractListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              const ContractBackButton(),
              SizedBox(height: 28.h),
              const ContractPageTitle(title: 'ข้อมูลสัญญาทั้งหมด'),
              SizedBox(height: 28.h),
              Expanded(
                child: contractState.when(
                  data: (contracts) {
                    if (contracts.isEmpty) {
                      return Center(
                        child: Text(
                          'ไม่พบรายการสัญญา',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16.sp,
                            color: contractLabelTextColor,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: contracts.length,
                      separatorBuilder: (_, __) => SizedBox(height: 28.h),
                      itemBuilder: (context, index) {
                        final contract = contracts[index];
                        return ContractCard(
                          contract: contract,
                          onPay: () {
                            context.pushNamed(
                              AppRouter.payment,
                              extra: PaymentExtra(
                                contractId: contract.contractId,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
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
                child: ContractPrimaryButton(
                  label: 'เพิ่มสัญญา',

                  onPressed: () => context.pushNamed(AppRouter.createContract),
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }
}
