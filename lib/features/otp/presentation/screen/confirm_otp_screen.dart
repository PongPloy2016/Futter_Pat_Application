import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/app_router.dart';
import '../../../../router/extras/create_pin_extra.dart';
import '../../../../shared/widgets/custom_text_default.dart';
import '../../../../shared/widgets/otp/otp_countdown.dart';
import '../../../../shared/widgets/otp/otp_form.dart';
import '../../../../shared/widgets/button/buttons.dart';
import '../../domain/entities/otp_entity.dart';
import '../providers/otp_provider.dart';

class ConfirmOtpScreen extends ConsumerStatefulWidget {
  const ConfirmOtpScreen({
    super.key,
    required this.empId,
    required this.otpData,
  });

  final String empId;
  final OtpEntity? otpData;

  @override
  ConsumerState<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends ConsumerState<ConfirmOtpScreen> {
  final GlobalKey<OtpFormState> _otpFormStateKey = GlobalKey();
  final GlobalKey<OtpCountdownState> _countDownStateKey = GlobalKey();

  dynamic /*OTPTextEditController?*/
  _otpController; // Optional, only used on Android
  dynamic /*OTPInteractor?*/ _otpInteractor; // Optional, only used on Android
  String _otp = '';
  bool _isSubmit = false;
  bool _isResend = false;
  bool _isOutOfTime = false;
  int _isWrongOtpCount = 0;
  OtpEntity? _resendOtpData;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      _initializeOtpAutoFill();
    }
  }

  void _initializeOtpAutoFill() {
    /*
    _otpInteractor = OTPInteractor();
    _otpInteractor
        ?.getAppSignature()
        .then((value) => print('🔴🔴🔴signature - $value🔴🔴🔴'));
    _otpController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        print('🔴🔴🔴Your Application receive code - $code🔴🔴🔴');
        setState(() {
          _otpFormStateKey.currentState?.setOtp(code);
        });
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [],
      );
    */
  }

  @override
  void dispose() {
    _otpController?.stopListen();
    super.dispose();
  }

  void _handleOtpChange(String otp) {
    setState(() {
      _otp = otp;
      _submit();
    });
  }

  Future<void> _submit() async {
    if (_otp.length != 6 || _isSubmit || _isWrongOtpCount >= 3) return;

    setState(() {
      _isSubmit = true;
    });

    try {
      final otpNotifier = ref.read(otpProvider.notifier);
      final currentOtpData = _resendOtpData ?? widget.otpData;

      final isVerified = await otpNotifier.verifyOtp(
        empId: widget.empId,
        otpValue: _otp,
        codeReference: currentOtpData?.codeReference ?? '',
        token: currentOtpData?.token ?? '',
      );

      setState(() {
        _isSubmit = false;
      });

      if (isVerified) {
        if (mounted) {
          context.goNamed(
            AppRouter.createPin,
            extra: CreatePinExtra(empId: widget.empId),
          );
        }
      } else {
        setState(() {
          _isWrongOtpCount++;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('รหัส OTP ไม่ถูกต้อง')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isSubmit = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _resend() async {
    if (_isResend) return;

    _otpFormStateKey.currentState?.disable(false);
    _otpFormStateKey.currentState?.reset();

    setState(() {
      _isResend = true;
      _isOutOfTime = false;
      _otp = '';
    });

    try {
      final otpNotifier = ref.read(otpProvider.notifier);
      final result = await otpNotifier.requestOtp(empId: widget.empId);

      setState(() {
        _isResend = false;
        _isWrongOtpCount = 0;
      });

      if (result != null) {
        setState(() {
          _resendOtpData = result;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _countDownStateKey.currentState?.startCountdown();
          });
        });

        _countDownStateKey.currentState?.stopCountdown();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ส่ง OTP ใหม่สำเร็จ')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isResend = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _handleOnOutOfTime() {
    setState(() {
      _isOutOfTime = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Image.asset(
                  'lib/assets/images/pat_logo_image.png',
                  height: 180.h,
                  width: 180.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 48.h),
                CustomTextDefault(
                  text: 'เข้าสู่ระบบ',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF009ADB),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextDefault(
                  text: 'ยืนยันรหัส OTP',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 48.h),
                OtpForm(key: _otpFormStateKey, onChanged: _handleOtpChange),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextDefault(
                      text: 'Ref : ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    CustomTextDefault(
                      text:
                          _resendOtpData?.codeReference ??
                          widget.otpData?.codeReference ??
                          "-",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                OtpCountdown(
                  key: _countDownStateKey,
                  onOutOfTime: _handleOnOutOfTime,
                  expireDate:
                      _resendOtpData?.expireDate ??
                      widget.otpData?.expireDate ??
                      DateTime.now()
                          .add(const Duration(minutes: 5))
                          .toIso8601String(),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextDefault(
                      text: 'ยังไม่ได้รับรหัส OTP ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                    ),
                    _isResend
                        ? SizedBox(
                            width: 14.sp,
                            height: 14.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _resend(),
                            child: CustomTextDefault(
                              text: 'ส่งอีกครั้ง',
                              style: TextStyle(
                                color: const Color(0xFF009ADB),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 48.h),
                _isSubmit
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ButtonCustomeAction(
                          label: 'ยืนยัน',
                          onPressed: () {
                            _submit();
                          },
                        ),
                      ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
