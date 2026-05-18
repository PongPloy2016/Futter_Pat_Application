import 'package:flutter_pat_application/features/otp/domain/entities/otp_entity.dart';

/// Extra data class สำหรับส่งพารามิเตอร์ไปยัง ConfirmOtpScreen ผ่าน GoRouter
class ConfirmOtpExtra {
  final String empId;
  final OtpEntity? otpData;

  const ConfirmOtpExtra({
    required this.empId,
    this.otpData,
  });
}
