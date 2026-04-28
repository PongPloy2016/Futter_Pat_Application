import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import '../../../themes/colors.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onNumberTap;
  final VoidCallback onDeleteTap;
  final bool canCheckBiometrics;
  final bool disable;

  const NumberPad({
    super.key,
    required this.onNumberTap,
    required this.onDeleteTap,
    this.canCheckBiometrics = false,
    this.disable = false,
  });

  Widget _buildNumberButton(String number) {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          foregroundColor: const Color(0xFF008ED7),
        ),
        onPressed: disable == false ? () => onNumberTap(number) : null,
        child: Text(
          number,
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF008ED7),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          foregroundColor: const Color(0xFF008ED7),
        ),
        onPressed: onDeleteTap,
        child: Icon(
          Icons.backspace_outlined,
          size: 36.sp,
          color: const Color(0xFF008ED7),
        ),
      ),
    );
  }

  Widget _buildFingerprintScanButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          elevation: 0.1,
        ),
        onPressed: () async {
          // ตรวจสอบว่ารองรับ Biometric หรือไม่
          if (!kIsWeb &&
              (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)) {
            final LocalAuthentication auth = LocalAuthentication();
            bool authenticated = false;

            try {
              // authenticated = await auth.authenticate(
              //   localizedReason: 'Scan your fingerprint to login',
              //   options: const AuthenticationOptions(
              //     biometricOnly: true,
              //   ),
              // );

              if (authenticated) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const MainScreen(),
                //   ),
                // );
              }
            } catch (e) {
              print('Error while authenticating: $e');
            }
          } else {
            print('Biometric authentication is not supported on this platform');
          }
        },
        child: const Icon(Icons.fingerprint, size: 40, color: Color(textColor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio:
                    ScreenUtil().screenWidth /
                    (ScreenUtil().screenHeight /
                        (constraints.maxWidth >= 600 ? 2.5 : 2)),
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                  const SizedBox.shrink(),
                  // สร้างปุ่มสำหรับสแกน fingerprint หากรองรับ
                  // canCheckBiometrics
                  //     ? _buildFingerprintScanButton(context)
                  //     : const SizedBox.shrink(),
                  _buildNumberButton('0'),
                  _buildDeleteButton(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
