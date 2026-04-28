import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

class AppointmentDocumentScreen extends StatefulWidget {
  const AppointmentDocumentScreen({super.key});

  @override
  State<AppointmentDocumentScreen> createState() =>
      _AppointmentDocumentScreenState();
}

class _AppointmentDocumentScreenState extends State<AppointmentDocumentScreen> {
  List<PlatformFile> _naturalPersonFiles = [];
  List<PlatformFile> _juristicPersonFiles = [];

  Future<void> _pickFile(bool isNaturalPerson) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        List<PlatformFile> validFiles = [];
        bool hasOversizedFile = false;

        for (var file in result.files) {
          final fileSizeInMB = file.size / (1024 * 1024);
          if (fileSizeInMB > 10) {
            hasOversizedFile = true;
          } else {
            validFiles.add(file);
          }
        }

        if (hasOversizedFile) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'ไฟล์บางไฟล์มีขนาดเกิน 10 MB และไม่ถูกเลือก',
                  style: TextStyle(fontFamily: 'Kanit'),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }

        setState(() {
          if (isNaturalPerson) {
            for (var file in validFiles) {
              if (!_naturalPersonFiles.any(
                (e) => e.name == file.name && e.size == file.size,
              )) {
                _naturalPersonFiles.add(file);
              }
            }
          } else {
            for (var file in validFiles) {
              if (!_juristicPersonFiles.any(
                (e) => e.name == file.name && e.size == file.size,
              )) {
                _juristicPersonFiles.add(file);
              }
            }
          }
        });

        if (validFiles.isNotEmpty && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'เพิ่มไฟล์สำเร็จ ${validFiles.length} ไฟล์',
                style: const TextStyle(fontFamily: 'Kanit'),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'เกิดข้อผิดพลาด: $e',
              style: const TextStyle(fontFamily: 'Kanit'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeFile(bool isNaturalPerson, PlatformFile file) {
    setState(() {
      if (isNaturalPerson) {
        _naturalPersonFiles.remove(file);
      } else {
        _juristicPersonFiles.remove(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context),
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
                        _DocumentRequirementCard(
                          title: 'กรณีผู้เช่าเป็นบุคคลธรรมดา',
                          documents: const [
                            'สำเนาบัตรประชาชน (พร้อมรับรองสำเนาถูกต้อง)',
                            'สำเนาทะเบียนบ้าน (พร้อมรับรองสำเนาถูกต้อง)',
                            'สำเนาใบเสร็จค่าเช่าเดือนที่ท่านมาทำสัญญา',
                            'ใบเสร็จเงินประกันการปฏิบัติตามสัญญาเช่า (ฉบับจริง)',
                          ],
                          powerOfAttorneyDocuments: const [
                            'หนังสือมอบอำนาจ (พร้อมปิดอากรแสตมป์ 10 บาท)',
                            'สำเนาบัตรประชาชนของผู้รับมอบอำนาจ (พร้อมรับรองสำเนาถูกต้อง)',
                          ],
                          selectedFiles: _naturalPersonFiles,
                          onAttach: () => _pickFile(true),
                          onDeleteFile: (file) => _removeFile(true, file),
                        ),
                        SizedBox(height: 20.h),
                        _DocumentRequirementCard(
                          title: 'กรณีผู้เช่าเป็นนิติบุคคล',
                          documents: const [
                            'หนังสือรับรองบริษัท/ห้างหุ้นส่วนจำกัด ที่ออกโดยกรมพัฒนาธุรกิจการค้ากระทรวงพาณิชย์ (ที่ออกไม่เกิน 6 เดือน)',
                            'สำเนาบัตรประชาชนของผู้มีอำนาจลงนาม (พร้อมรับรองสำเนาถูกต้อง)',
                            'สำเนาทะเบียนบ้านของผู้มีอำนาจลงนาม (พร้อมรับรองสำเนาถูกต้อง)',
                            'สำเนาใบเสร็จค่าเช่าเดือนที่ท่านมาทำสัญญา',
                            'ใบเสร็จเงินประกันการปฏิบัติตามสัญญาเช่า (ฉบับจริง)',
                          ],
                          powerOfAttorneyDocuments: const [
                            'หนังสือมอบอำนาจ (พร้อมปิดอากรแสตมป์ 10 บาท)',
                            'สำเนาบัตรประชาชนของผู้รับมอบอำนาจ (พร้อมรับรองสำเนาถูกต้อง)',
                          ],
                          selectedFiles: _juristicPersonFiles,
                          onAttach: () => _pickFile(false),
                          onDeleteFile: (file) => _removeFile(false, file),
                        ),
                        SizedBox(height: 100.h), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Button
            Positioned(
              bottom: 24.h,
              left: 24.w,
              right: 24.w,
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: บันทึกข้อมูล
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009ADB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF009ADB).withOpacity(0.4),
                  ),
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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

class _DocumentRequirementCard extends StatelessWidget {
  const _DocumentRequirementCard({
    required this.title,
    required this.documents,
    required this.powerOfAttorneyDocuments,
    required this.onAttach,
    required this.selectedFiles,
    required this.onDeleteFile,
  });

  final String title;
  final List<String> documents;
  final List<String> powerOfAttorneyDocuments;
  final VoidCallback onAttach;
  final List<PlatformFile> selectedFiles;
  final Function(PlatformFile) onDeleteFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        gradient: const LinearGradient(
          colors: [Color(0xFFEDEFF8), Colors.white],
          stops: [0.0, 0.25],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8BED9).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2B478B),
              ),
            ),
            SizedBox(height: 12.h),
            ...documents.map(
              (doc) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  doc,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF222222),
                    height: 1.4,
                  ),
                ),
              ),
            ),
            if (powerOfAttorneyDocuments.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                'กรณีมอบอำนาจ (ถ้ามี)',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2B478B),
                ),
              ),
              SizedBox(height: 12.h),
              ...powerOfAttorneyDocuments.map(
                (doc) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    doc,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF222222),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 16.h),
            Row(
              children: [
                SizedBox(
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: onAttach,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3A93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      elevation: 2,
                    ),
                    child: Text(
                      'แนบไฟล์',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (selectedFiles.isNotEmpty) ...[
              SizedBox(height: 16.h),
              ...selectedFiles.map((file) {
                final fileSizeInMB = (file.size / (1024 * 1024))
                    .toStringAsFixed(2);
                final fileExt = file.extension?.toUpperCase() ?? '';
                final now = DateTime.now();
                final months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                ];
                final dateStr =
                    '${now.day} ${months[now.month - 1]}, ${now.year}';

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.insert_drive_file,
                              color: Colors.grey.shade300,
                              size: 36.sp,
                            ),
                            Positioned(
                              bottom: 4.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: fileExt == 'PDF'
                                      ? Colors.red
                                      : Colors.purpleAccent,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  fileExt.isNotEmpty ? fileExt : 'FILE',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file.name,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 14.sp,
                                  color: const Color(0xFF222222),
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '$fileSizeInMB MB . $dateStr',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 24.sp,
                            color: Colors.red.shade400,
                          ),
                          onPressed: () => onDeleteFile(file),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
