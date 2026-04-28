import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pat_application/features/pin/presentation/create_pin_screen.dart';
import 'package:flutter_pat_application/shared/widgets/otp/otp_countdown.dart';
import 'package:flutter_pat_application/shared/widgets/otp/otp_form.dart';
import 'package:flutter_pat_application/shared/widgets/button/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/app_router.dart';
import '../../../../router/extras/create_pin_extra.dart';
import '../../../../shared/widgets/custom_text_default.dart';
import '../../../auth/data/models/otp_model.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({
    super.key,
    required this.empId,
    required this.otpDataModel,
  });

  final String empId;
  final ResponseRequestOTPDataModel? otpDataModel; // Updated type

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  static const _storage = /*FlutterSecureStorage()*/
      null; // REPLACE WITH INSTANCE
  final GlobalKey<OtpFormState> _otpFormStateKey = GlobalKey(); // UPDATE TYPE
  final GlobalKey<OtpCountdownState> _countDownStateKey =
      GlobalKey(); // UPDATE TYPE

  dynamic /*OTPTextEditController?*/
  _otpController; // Optional, only used on Android
  dynamic /*OTPInteractor?*/ _otpInteractor; // Optional, only used on Android
  String _otp = '';
  bool _isSubmit = false;
  bool _isResend = false;
  bool _isOutOfTime = false;
  int _isWrongOtpCount = 0;
  ResponseRequestOTPDataModel? _resendOtpDataModel;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      // Use OTP autofill only on Android
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
          _otpFormStateKey.currentState?.setOtp(code); // Fill OTP into the form
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
    _otpController?.stopListen(); // Stop listening when the screen is disposed
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
      // final response = await RegisterService().verifyOtp(
      //   empId: widget.empId,
      //   otpValue: _otp,
      //   codeReference:
      //       _resendOtpDataModel?.codeReference ??
      //       widget.otpDataModel?.codeReference ??
      //       '', // Provide default value
      //   token:
      //       _resendOtpDataModel?.token ??
      //       widget.otpDataModel?.token ??
      //       '', // Provide default value
      // );

      setState(() {
        _isSubmit = false;
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreatePinScreen(
      //       empId: widget.empId,
      //       // Assert non-null after null check
      //     ),
      //   ),
      // );
      context.goNamed(
        AppRouter.createPin,
        extra: CreatePinExtra(empId: widget.empId),
      );
    } catch (e) {
      setState(() {
        _isSubmit = false;
      });
      // Handle error
      print('Error verifying OTP: $e');
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
      // final response = await RegisterService().requestOtp(empId: widget.empId);

      setState(() {
        _isResend = false;
        _isWrongOtpCount = 0;
      });

      /*
      if (response.item3 != null) {
        setState(() {
          _resendOtpDataModel = response.item3;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _countDownStateKey.currentState?.startCountdown();
          });
        });

        _countDownStateKey.currentState?.stopCountdown();
      }

      if (response.item1) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resend success')),
          );
        }
        return;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.item2)),
        );
      }
      */
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
    // if (widget.otpDataModel == null) {
    //   return Scaffold(body: Center(child: Text('Error: OTP data is missing.')));
    // }

    // Proceed with the widget tree if otpDataModel is not null
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
                          _resendOtpDataModel?.codeReference ??
                          widget.otpDataModel?.codeReference ??
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
                      _resendOtpDataModel?.expireDate ??
                      widget.otpDataModel?.expireDate ??
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
