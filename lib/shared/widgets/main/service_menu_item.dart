import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pat_application/shared/widgets/text/custom_text.dart';

class ServiceMenuItem extends StatelessWidget {
  final String name;
  final String iconpng;
  final VoidCallback onTap;

  const ServiceMenuItem({
    super.key,
    required this.name,
    required this.iconpng,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFFE3EEF4),
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconpng,
                  height: 40.w,
                  width: 40.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  name,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    fontFamily: 'Kanit',
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
