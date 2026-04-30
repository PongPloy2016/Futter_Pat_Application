import 'package:flutter/material.dart';
import 'package:flutter_pat_application/shared/widgets/button/button_customs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import '../providers/attach_file_provider.dart';
import '../widgets/document_requirement_card.dart';
import '../../data/models/document_model.dart';

class AttachFileDocumentsScreen extends ConsumerWidget {
  const AttachFileDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attachFileProvider);

    ref.listen<AttachFileState>(attachFileProvider, (previous, next) {
      if (next.hasOversizedError && (previous?.hasOversizedError != true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ไฟล์บางไฟล์มีขนาดเกิน 10 MB และไม่ถูกเลือก',
              style: TextStyle(fontFamily: 'Kanit'),
            ),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(attachFileProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomtitleCustomerAppBar(
        title: '',
        onSuccess: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildPageTitle(),
                        SizedBox(height: 8.h),
                        Text(
                          'กรุณาแนบไฟล์เอกสารเพื่อใช้ในการตรวจสอบก่อนนัดหมาย\n(รองรับไฟล์ PDF, PNG ขนาดไม่เกิน 10 MB)',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        DocumentRequirementCard(
                          title: 'กรณีผู้เช่าเป็นบุคคลธรรมดา',
                          documents: const [
                            '\t- สำเนาบัตรประชาชน (พร้อมรับรองสำเนาถูกต้อง)',
                            '\t- สำเนาทะเบียนบ้าน (พร้อมรับรองสำเนาถูกต้อง)',
                            '\t- สำเนาใบเสร็จค่าเช่าเดือนที่ท่านมาทำสัญญา',
                            '\t- ใบเสร็จเงินประกันการปฏิบัติตามสัญญาเช่า (ฉบับจริง)',
                          ],
                          powerOfAttorneyDocuments: const [
                            '\t- หนังสือมอบอำนาจ (พร้อมปิดอากรแสตมป์ 10 บาท)',
                            '\t- สำเนาบัตรประชาชนของผู้รับมอบอำนาจ (พร้อมรับรองสำเนาถูกต้อง)',
                          ],
                          selectedFiles: state.naturalPersonFiles,
                          onAttach: () => ref
                              .read(attachFileProvider.notifier)
                              .pickFiles(true),
                          onDeleteFile: (file) => ref
                              .read(attachFileProvider.notifier)
                              .removeFile(true, file),
                        ),
                        SizedBox(height: 20.h),
                        DocumentRequirementCard(
                          title: 'กรณีผู้เช่าเป็นนิติบุคคล',
                          documents: const [
                            '\t- หนังสือรับรองบริษัท/ห้างหุ้นส่วนจำกัด ที่ออกโดยกรมพัฒนาธุรกิจการค้ากระทรวงพาณิชย์ (ที่ออกไม่เกิน 6 เดือน)',
                            '\t- สำเนาบัตรประชาชนของผู้มีอำนาจลงนาม (พร้อมรับรองสำเนาถูกต้อง)',
                            '\t- สำเนาทะเบียนบ้านของผู้มีอำนาจลงนาม (พร้อมรับรองสำเนาถูกต้อง)',
                            '\t- สำเนาใบเสร็จค่าเช่าเดือนที่ท่านมาทำสัญญา',
                            '\t- ใบเสร็จเงินประกันการปฏิบัติตามสัญญาเช่า (ฉบับจริง)',
                          ],
                          powerOfAttorneyDocuments: const [
                            '\t- หนังสือมอบอำนาจ (พร้อมปิดอากรแสตมป์ 10 บาท)',
                            '\t- สำเนาบัตรประชาชนของผู้รับมอบอำนาจ (พร้อมรับรองสำเนาถูกต้อง)',
                          ],
                          selectedFiles: state.juristicPersonFiles,
                          onAttach: () => ref
                              .read(attachFileProvider.notifier)
                              .pickFiles(false),
                          onDeleteFile: (file) => ref
                              .read(attachFileProvider.notifier)
                              .removeFile(false, file),
                        ),
                        SizedBox(height: 100.h), // Space for bottom button
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Center(
                    child: PrimarySubmitsButton(
                      text: "บันทึก",
                      width: 200.w,
                      height: 50.h,
                      onPressed: () {
                        // Navigate to appointment renewal
                        final allEntities = [
                          ...state.naturalPersonFiles,
                          ...state.juristicPersonFiles,
                        ];
                        final allFiles = allEntities
                            .map((e) => (e as DocumentModel).toPlatformFile)
                            .toList();
                        context.pop(allFiles);
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Bottom Button
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009ADB), width: 1.5),
                color: Colors.white,
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFF009ADB),
                size: 24.sp,
              ),
            ),
          ),
          // Support Agent Avatar Placeholder
          Container(
            width: 42.w,
            height: 42.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8F0FE),
            ),
            child: Icon(
              Icons.support_agent_rounded,
              color: const Color(0xFF2B478B),
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitle() {
    return Row(
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
          'แนบไฟล์เอกสาร',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF009ADB),
          ),
        ),
      ],
    );
  }
}
