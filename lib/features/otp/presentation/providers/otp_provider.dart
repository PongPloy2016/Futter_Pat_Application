import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/otp_entity.dart';
import '../../domain/usecases/request_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

/// OTP State
sealed class OtpState {
  const OtpState();
}

class OtpInitial extends OtpState {
  const OtpInitial();
}

class OtpLoading extends OtpState {
  const OtpLoading();
}

class OtpRequestSuccess extends OtpState {
  final OtpEntity otpData;
  const OtpRequestSuccess(this.otpData);
}

class OtpVerifySuccess extends OtpState {
  const OtpVerifySuccess();
}

class OtpError extends OtpState {
  final String message;
  const OtpError(this.message);
}

/// OTP Notifier
class OtpNotifier extends StateNotifier<OtpState> {
  final RequestOtpUseCase _requestOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  OtpNotifier({
    required RequestOtpUseCase requestOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
  })  : _requestOtpUseCase = requestOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        super(const OtpInitial());

  /// ขอ OTP ใหม่
  Future<OtpEntity?> requestOtp({required String empId}) async {
    state = const OtpLoading();
    try {
      final result = await _requestOtpUseCase.execute(empId: empId);
      state = OtpRequestSuccess(result);
      return result;
    } catch (e) {
      state = OtpError('ไม่สามารถขอ OTP ได้: $e');
      return null;
    }
  }

  /// ยืนยัน OTP
  Future<bool> verifyOtp({
    required String empId,
    required String otpValue,
    required String codeReference,
    required String token,
  }) async {
    state = const OtpLoading();
    try {
      final result = await _verifyOtpUseCase.execute(
        empId: empId,
        otpValue: otpValue,
        codeReference: codeReference,
        token: token,
      );
      if (result) {
        state = const OtpVerifySuccess();
      } else {
        state = const OtpError('รหัส OTP ไม่ถูกต้อง');
      }
      return result;
    } catch (e) {
      state = OtpError('ไม่สามารถยืนยัน OTP ได้: $e');
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const OtpInitial();
  }
}

/// Provider
final otpProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  return OtpNotifier(
    requestOtpUseCase: sl<RequestOtpUseCase>(),
    verifyOtpUseCase: sl<VerifyOtpUseCase>(),
  );
});
