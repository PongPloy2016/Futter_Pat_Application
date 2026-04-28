import 'package:flutter_pat_application/features/auth/data/models/otp_model.dart';

/// Extra data class สำหรับส่งพารามิเตอร์ไปยัง ConfirmPinScreen ผ่าน GoRouter
class ConfirmPinExtra {
  final String empId;
  final String pin;
  final ResponseRequestOTPDataModel otpDataModel;

  const ConfirmPinExtra({
    required this.empId,
    required this.pin,
    required this.otpDataModel,
  });
}
