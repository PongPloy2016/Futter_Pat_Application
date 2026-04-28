import 'package:flutter/material.dart';

import 'otp_form_field.dart';

class OtpForm extends StatefulWidget {
  final Function(String) onChanged;

  const OtpForm({super.key, required this.onChanged});

  @override
  State<OtpForm> createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<String> _otps = List.generate(6, (_) => '');
  bool enabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) {
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      }
    });
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleOtpChange(String value, int index) {
    setState(() {
      _otps[index] = value;
      widget.onChanged(_otps.join(''));
    });

    if (value.isNotEmpty) {
      // ถ้ามีการกรอกข้อมูล ให้ขยับไปที่ช่องถัดไป
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (value.isEmpty && index > 0) {
      // ถ้าลบข้อมูลในช่องแล้วว่าง ให้ย้ายไปที่ช่องก่อนหน้า
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void reset() {
    setState(() {
      for (int i = 0; i < 6; i++) {
        _otps[i] = '';
        _controllers[i].clear();
      }
      widget.onChanged(_otps.join(''));
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  void disable(bool value) {
    setState(() {
      enabled = !value;
    });
  }

  // เพิ่มฟังก์ชัน setOtp เพื่อเติม OTP อัตโนมัติ
  void setOtp(String otp) {
    for (int i = 0; i < otp.length && i < 6; i++) {
      _controllers[i].text = otp[i];
      _otps[i] = otp[i];
    }
    widget.onChanged(_otps.join(''));
    print('🔴🔴🔴 OTP received and autofilled: $otp 🔴🔴🔴');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: SizedBox(
              width: 48.0, // Increased from 40.0
              height: 48.0, // Increased from 40.0
              child: OtpFormField(
                focusNode: _focusNodes[index],
                nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
                previousFocusNode: index > 0 ? _focusNodes[index - 1] : null,
                controller: _controllers[index],
                enabled: enabled,
                onChanged: (value) => _handleOtpChange(value, index),
                onAutoFill: (value) => setOtp(value),
              ),
            ),
          );
        }),
      ),
    );
  }
}
