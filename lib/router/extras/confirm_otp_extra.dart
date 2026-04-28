import 'package:flutter_pat_application/features/auth/data/models/otp_model.dart';

/// Extra data class สำหรับส่งพารามิเตอร์ไปยัง ConfirmOtpScreen ผ่าน GoRouter
class ConfirmOtpExtra {
  final String empId;
  final ResponseRequestOTPDataModel? otpDataModel;

  const ConfirmOtpExtra({
    required this.empId,
    this.otpDataModel,
  });
}
