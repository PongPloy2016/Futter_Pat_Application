import 'package:flutter/material.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/features/otp/presentation/screen/confirm_otp_screen.dart';
import 'package:flutter_pat_application/shared/widgets/custom_text_default.dart';
import 'package:flutter_pat_application/shared/widgets/textFrom/custom_text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/app_router.dart';
import '../../../../../router/extras/confirm_otp_extra.dart';
import '../../../../../shared/widgets/logo/logo_create_pin.dart';
import '../../../../otp/domain/entities/otp_entity.dart';
import '../../../data/models/otp_model.dart';
import 'package:flutter_pat_application/core/utils/widget_extensions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 0 = Phone, 1 = ThaID
  int _selectedTabIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idCardController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _idCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFF5), // Light blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF009ADB)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 40.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // PAT Logo
            LogoCreatePinWidget(),
            const SizedBox(height: 20),
            // Title
            const CustomTextDefault(
              text: "ลงทะเบียนใช้งาน",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF009ADB),
              ),
            ),
            const SizedBox(height: 30),
            // Segmented Control (Toggle Tab)
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Row(
                children: [
                  _buildTabItem(title: "เบอร์โทรศัพท์", index: 0),
                  _buildTabItem(title: "ThaID", index: 1),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Content area based on selected tab
            _selectedTabIndex == 0 ? _buildPhoneTab() : _buildThaIDTab(),
          ],
        ),
      ).withWhiteCardLayout().withLoginBackground(),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF009ADB) : Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF009ADB).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: CustomTextDefault(
              text: title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTab() {
    return Column(
      children: [
        CustomTextFormField(
          controller: _phoneController,
          hintText: "กรอกเบอร์โทรศัพท์",
          obscureText: false,
          keyboardType: TextInputType.phone,
          inputDecoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
            hintText: "กรอกเบอร์โทรศัพท์",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _idCardController,
          hintText: "เลขบัตรประจำตัวประชาชน",
          obscureText: false,
          keyboardType: TextInputType.number,
          inputDecoration: InputDecoration(
            prefixIcon: const Icon(Icons.badge_outlined, color: Colors.grey),
            hintText: "เลขบัตรประจำตัวประชาชน",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 40),
        _buildActionButton(
          label: "กดรับรหัส OTP",
          onPressed: () {
            // TODO: Handle OTP
            context.goNamed(
              AppRouter.confirmOtp,
              extra: ConfirmOtpExtra(
                empId: '1234', // TODO: ใส่ empId จริงจาก Form
                otpData: const OtpEntity(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildThaIDTab() {
    return Column(
      children: [
        // ThaID Logo Placeholder
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF031652), // Dark blue ThaID color
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tha",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ID",
                  style: TextStyle(
                    color: Color(0xFFFFC107),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        const CustomTextDefault(
          text: "ใช้แอป ThaID เพื่อยืนยันลงทะเบียนใช้งาน",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 40),
        _buildActionButton(
          label: "เชื่อมต่อ ThaID",
          onPressed: () {
            // TODO: Handle ThaID connect
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009ADB).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF009ADB), Color(0xFF00B4FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: CustomTextDefault(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: fontSize4_Button,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
