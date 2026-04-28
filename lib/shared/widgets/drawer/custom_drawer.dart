import 'package:flutter/material.dart';
import 'package:flutter_pat_application/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:go_router/go_router.dart';

import '../../../features/payment_card/presentation/screens/payment_card_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: textFromMenu,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: textFromMenu),
            child: Image.asset(
              'lib/assets/images/pat_logo_image.png',
              height: 20.w,
              width: 20.w,
              fit: BoxFit.scaleDown,
            ),
          ),

          ListTile(
            tileColor: textFromMenu,
            leading: Image.asset(
              'lib/assets/images/ic_user_profile.png',
              height: 20.w,
              width: 20.w,
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              'หน้าแรก',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize5_Body.sp,
                fontFamily: fontFamily,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: textFromMenu,
            leading: Image.asset(
              'lib/assets/images/ic_credit_card.png',
              height: 20.w,
              width: 20.w,
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              'บัตรชำระเงิน',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize5_Body.sp,
                fontFamily: fontFamily,
              ),
            ),
            onTap: () {
              context.pop();
              context.pushNamed(AppRouter.paymentCard);
            },
          ),
          ListTile(
            tileColor: textFromMenu,
            leading: Image.asset(
              'lib/assets/images/ic_video.png',
              height: 20.w,
              width: 20.w,
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              'Video แนะนำการใช้งาน',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize5_Body.sp,
                fontFamily: fontFamily,
              ),
            ),
            onTap: () {
              context.pop();
              context.pushNamed(AppRouter.payment);
            },
          ),
          ListTile(
            tileColor: textFromMenu,
            leading: Image.asset(
              'lib/assets/images/ic_logout.png',
              height: 20.w,
              width: 20.w,
              fit: BoxFit.contain,
            ),
            title: Text(
              'ออกจากระบบ',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize5_Body.sp,
                fontFamily: fontFamily,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
