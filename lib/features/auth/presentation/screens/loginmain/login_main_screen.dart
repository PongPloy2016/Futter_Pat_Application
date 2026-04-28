import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/custom_text_default.dart';
import 'package:flutter_pat_application/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/button/buttons.dart';

class LoginMainScreen extends StatelessWidget {
  const LoginMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFF5), // Light blue background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 60.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // PAT Logo
                    Image.asset(
                      "lib/assets/images/pat_logo_image.png", // Path ของภาพ
                      width: 180,
                      height: 180,
                      scale: 1,
                    ),
                    const SizedBox(height: 80),
                    // Login Button
                    ButtonCustomeAction(
                      label: 'ลงชื่อเข้าใช้งาน',
                      onPressed: () {
                        context.goNamed(AppRouter.register);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Register Button
                    ButtonCustomeAction(
                      label: 'ลงทะเบียนใช้งาน',
                      onPressed: () {
                        context.goNamed(AppRouter.register);
                      },
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
