import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/logo/logo_create_pin.dart';
import '../../../shared/widgets/pin/number_pad.dart';

import '../../../themes/fontsize.dart';
import '../../auth/data/models/otp_model.dart';
import 'package:flutter_pat_application/features/pin/presentation/confirm_pin_screen.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/app_router.dart';
import '../../../../router/extras/confirm_pin_extra.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key, required this.empId});

  final String empId;

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';

  void _onNumberTap(String number) async {
    if (_pin.length < 6) {
      setState(() {
        _pin += number;
        if (_pin.length == 6) {
          if (mounted) {
            context.goNamed(
              AppRouter.confirmPin,
              extra: ConfirmPinExtra(
                empId: widget.empId,
                pin: _pin,
                otpDataModel: ResponseRequestOTPDataModel(),
              ),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ConfirmPinScreen(
            //       empId: widget.empId,
            //       pin: _pin,
            //       otpDataModel: widget.otpDataModel,
            //     ),
            //   ),
            // ).then((value) {
            //   if (value == true) {
            //     setState(() {
            //       _pin = '';
            //     });
            //   }
            // });
          }
        }
      });
    }
  }

  void _onDeleteTap() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  Widget _buildPinCircles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        bool isFilled = index < _pin.length;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled ? const Color(0xFF008ED7) : Colors.transparent,
              border: isFilled
                  ? null
                  : Border.all(color: const Color(0xFF9CA3AF), width: 1.5),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitle() {
    return Text(
      'สร้าง PIN ใหม่',
      style: TextStyle(
        fontSize: fontSize1_Headline.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF008ED7),
      ),
    );
  }

  Widget _buildTitleDetail() {
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(leading: null), // ซ่อนปุ่ม Back
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const LogoCreatePinWidget(),
              SizedBox(height: 10.h),
              _buildTitle(),
              SizedBox(height: 10.h),
              _buildTitleDetail(),
              SizedBox(height: 20.h),
              _buildPinCircles(),
              SizedBox(height: 20.h),
              Expanded(
                child: NumberPad(
                  onNumberTap: _onNumberTap,
                  onDeleteTap: _onDeleteTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
