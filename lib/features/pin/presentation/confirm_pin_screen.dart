import 'package:flutter/material.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../router/app_router.dart';
import '../../../shared/widgets/logo/logo_create_pin.dart';
import '../../../shared/widgets/pin/number_pad.dart';
import '../../../themes/colors.dart';
import '../../auth/data/models/otp_model.dart';
import '../../home/presentation/layout/bottomnavpage/navigationBarScreen.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({
    super.key,
    required this.empId,
    required this.pin,
    required this.otpDataModel,
  });

  final String empId;
  final String pin;
  final ResponseRequestOTPDataModel otpDataModel;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  static const _storage = FlutterSecureStorage();
  String _pinConfirm = '';

  void _onNumberTap(String number) async {
    if (_pinConfirm.length < 6) {
      setState(() {
        _pinConfirm += number;
      });

      if (_pinConfirm.length == 6) {
        if (_pinConfirm != widget.pin) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'เกิดข้อผิดพลาด',
            text: 'PIN ไม่ตรงกัน',
            confirmBtnText: "OK" ?? '',
            onConfirmBtnTap: () {
              context.pop();
            },
          );
        } else {
          context.goNamed(AppRouter.navigationBar);
          //await _updatePin();
        }
      }
    }
  }

  void _onDeleteTap() {
    if (_pinConfirm.isNotEmpty) {
      setState(() {
        _pinConfirm = _pinConfirm.substring(0, _pinConfirm.length - 1);
      });
    }
  }

  // Future<void> _updatePin() async {
  //   try {
  //     final response = await UserService().updatePin(
  //       empId: widget.empId,
  //       pin: widget.pin,
  //       codeReference: widget.otpDataModel.codeReference!,
  //       token: widget.otpDataModel.token!,
  //     );
  //     if (response.item1) {
  //       await _storage.write(key: AuthStorage.empIdKey, value: widget.empId);
  //       await _login();
  //       return;
  //     }

  //     if (mounted) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.error,
  //         title: 'เกิดข้อผิดพลาด',
  //         text: response.item2,
  //         confirmBtnText: AppLocalizations.of(context)?.ok_button ?? '',
  //         onConfirmBtnTap: () {
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.error,
  //         title: 'เกิดข้อผิดพลาด',
  //         text: '$e',
  //         confirmBtnText: AppLocalizations.of(context)?.ok_button ?? '',
  //         onConfirmBtnTap: () {
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   }
  // }

  // Future<void> _login() async {

  //     final empId = await context.readEmpIdOrNotify(emptyMessage: ' เกิดข้อผิดพลาด กรุณาเข้าสู่ระบบใหม่ อีกครั้ง',);
  // if (empId == null) return;

  //   try {

  //     final response = await AuthService().login(pin: widget.pin, empId: empId);
  //     if (response.item1) {
  //       if (mounted) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => const MainScreen()),
  //             (Route route) => false);
  //       }
  //       return;
  //     }

  //     if (mounted) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.success,
  //         title: 'สำเร็จ',
  //         text: response.item2,
  //         confirmBtnText: AppLocalizations.of(context)?.ok_button ?? '',
  //         onConfirmBtnTap: () {
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.error,
  //         title: 'เกิดข้อผิดพลาด',
  //         text: '$e',
  //         confirmBtnText: AppLocalizations.of(context)?.ok_button ?? '',
  //         onConfirmBtnTap: () {
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   }
  // }

  Widget _buildPinCircles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < _pinConfirm.length
                  ? const Color(successColor)
                  : Colors.white,
              border: index < _pinConfirm.length
                  ? null
                  : Border.all(color: const Color(0x606B7280)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitle() {
    return Text(
      'ยืนยัน PIN อีกครั้ง',
      style: TextStyle(
        fontSize: fontSize1_Headline.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF008ED7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(leading: null),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const LogoCreatePinWidget(),
              SizedBox(height: 10.h),
              _buildTitle(),

              SizedBox(height: 20.h),
              _buildPinCircles(),
              SizedBox(height: 20.h),
              Expanded(
                child: NumberPad(
                  onNumberTap: _onNumberTap,
                  onDeleteTap: _onDeleteTap,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 20.h),
                  child: InkWell(
                    onTap: () => context.pop(),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFF0653B1)),
                        ),
                      ),
                      child: Text("back_button" ?? ''),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
