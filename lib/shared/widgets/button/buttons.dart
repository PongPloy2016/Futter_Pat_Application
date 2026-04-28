import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_text_default.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.type = 'primary',
    this.size = 'normal',
    this.onPressed,
    this.icon,
  });

  final String text;
  final String? type;
  final String? size;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Tuple2<Color, Color> colors = getColors(type);
    Color bgColor = colors.item1;
    Color fgColor = colors.item2;

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
    );

    Widget renderText = CustomText(
      text,
      textStyle: TextStyle(
        fontSize: size == 'small' ? fontSize6_Detail.sp : fontSize4_Button.sp,
      ),
    );

    if (icon != null) {
      renderText = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: fgColor, size: size == 'small' ? 16.sp : 20.sp),
          SizedBox(width: 5.w),
          renderText,
        ],
      );
    }
    return size == 'small'
        ? SizedBox(
            //  height: 30.0.h,
            child: ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: renderText,
            ),
          )
        : SizedBox(
            // height: 40.0.h,
            child: ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: renderText,
            ),
          );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.type = 'primary',
    this.size = 'normal',
    this.onPressed,
    this.icon,
  });

  final String text;
  final String? type;
  final String? size;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Tuple2<Color, Color> colors = getColors(type);
    Color bgColor = colors.item1;

    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: bgColor,
      side: BorderSide(color: bgColor, width: 1.0.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
    );

    // Widget renderText = CustomText(
    //   text,
    //   textStyle: TextStyle(
    //    fontFamily: fontFamily,
    //     fontSize: size == 'small' ? fontSize7_Caption.sp : fontSize5_Body.sp,
    //   ),
    // );

    Widget renderText = DefaultTextStyle(
      style: TextStyle(
        color: bgColor,
        fontFamily: fontFamily,
        fontSize: size == 'small' ? fontSize7_Caption.sp : fontSize4_Button.sp,
      ),
      child: Text(text),
    );

    if (icon != null) {
      renderText = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: bgColor, size: size == 'small' ? 16.sp : 20.sp),
          SizedBox(width: 5.w),
          renderText,
        ],
      );
    }

    return size == 'small'
        ? OutlinedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: renderText,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 2.w),
              child: renderText,
            ),
          );
  }
}

Tuple2<Color, Color> getColors(String? type) {
  switch (type) {
    case 'primary':
      return const Tuple2(Color.fromARGB(255, 47, 145, 104), Colors.white);
    case 'secondary':
      return const Tuple2(Color(blackColor), Colors.white);
    case 'success':
      return const Tuple2(Color(successColor), Colors.white);
    case 'info':
      return const Tuple2(Color(infoColor), Colors.white);
    case 'warning':
      return const Tuple2(Color(warningColor), Colors.white);
    case 'error':
      return const Tuple2(Color(errorColor), Colors.white);
    default:
      return const Tuple2(Color(primaryColor), Colors.white);
  }
}

class ButtonCustomeAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonCustomeAction({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009ADB).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF009ADB), Color(0xFF00B4FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: CustomTextDefault(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: fontSize4_Button,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }
}
