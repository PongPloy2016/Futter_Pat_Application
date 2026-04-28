import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/colors.dart';

class OtpFormField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String) onAutoFill;
  final bool? enabled;

  const OtpFormField({
    super.key,
    required this.focusNode,
    this.nextFocusNode,
    required this.controller,
    required this.onChanged,
    required this.onAutoFill,
    this.enabled = true,
    required this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode:
          FocusNode(), // Use a separate focus node for RawKeyboardListener
      onKey: (event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            controller.text.isEmpty) {
          onChanged('');
          if (previousFocusNode != null) {
            FocusScope.of(context).requestFocus(previousFocusNode!);
          }
        }
      },
      child: TextField(
        autofillHints: const [AutofillHints.oneTimeCode],
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 6,
        enabled: enabled,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(inputBorderColor)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(inputBorderColor)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF009ADB), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            FocusScope.of(context).requestFocus(focusNode);
          } else if (value.isNotEmpty && value.length <= 2) {
            controller.text = value[value.length - 1];
            onChanged(value[value.length - 1]);
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode!);
            }
          } else {
            onAutoFill(value);
          }
        },
        onTap: () {
          // Set cursor position to the end of the text line
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          });
        },
      ),
    );
  }
}
