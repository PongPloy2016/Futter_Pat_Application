import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/custom_text_default.dart';
import 'package:flutter_pat_application/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/button/buttons.dart';
import '../../../../../shared/widgets/logo/logo_create_pin.dart';

import 'package:flutter_pat_application/core/utils/widget_extensions.dart';

class LoginMainScreen extends StatelessWidget {
  const LoginMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 3),
          // Logo PAT PROPERTY+
          // _buildLogo(),
          LogoCreatePinWidget(
            width: 250,
            height: 250,
            scale: 1,
          ),
          const SizedBox(height: 60),
          // Welcome Text
          const Text(
            'Welcome',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9EA6A9),
            ),
          ),
          const Spacer(flex: 2),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                _buildActionButton(
                  label: 'เข้าสู่ระบบ',
                  onPressed: () => context.pushNamed(AppRouter.login),
                  backgroundColor: const Color(0xFF75D1F2),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  label: 'ลงทะเบียน',
                  onPressed: () => context.pushNamed(AppRouter.register),
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF75D1F2),
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
          // Footer
          _buildFooter(),
          const SizedBox(height: 20),
        ],
      ).withLoginBackground(),
    );
  }

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PAT',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 70,
            fontWeight: FontWeight.w900,
            color: Color(0xFF9EA6A9),
            height: 0.9,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              'PROPERTY',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 45,
                fontWeight: FontWeight.w900,
                color: Color(0xFF9EA6A9),
                letterSpacing: 1.5,
                height: 0.9,
              ),
            ),
            const SizedBox(width: 4),
            Baseline(
              baseline: 30, // Adjust this value to align the + correctly
              baselineType: TextBaseline.alphabetic,
              child: Text(
                '+',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF75D1F2),
                  height: 0.9,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Text(
          'Contact us',
          style: TextStyle(
            fontFamily: 'Kanit',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _socialIcon('f', Colors.blue),
              const SizedBox(width: 12),
              _socialIcon('ig', Colors.orange), // Simplified for now
              const SizedBox(width: 12),
              _socialIcon('line', Colors.green),
              const SizedBox(width: 12),
              _socialIcon('yt', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _socialIcon(String label, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        gradient: label == 'ig'
            ? const RadialGradient(
                colors: [
                  Colors.yellow,
                  Colors.orange,
                  Colors.pink,
                  Colors.purple
                ],
                center: Alignment.bottomLeft,
                radius: 1.0,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: label == 'f'
          ? const Icon(Icons.facebook, color: Colors.blue, size: 20)
          : label == 'ig'
              ? const Icon(Icons.camera_alt_outlined,
                  color: Colors.white, size: 16)
              : Text(
                  label == 'line' ? 'L' : 'Y',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
    );
  }
}
