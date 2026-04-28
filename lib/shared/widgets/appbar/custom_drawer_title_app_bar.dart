import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawerTitleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDrawerTitleAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.actions,
    this.onSuccess,
  });

  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(primaryColor),
      title: CustomText(
        title,
        textAlign: TextAlign.center,
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: fontBold,
          fontSize: fontSize4_Button.sp,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            'lib/assets/icons/fi_list_bars.svg',
            width: 24.w,
            height: 24.h,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'lib/assets/icons/ic_notification_white.png',
            width: 24.w,
            height: 24.h,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'lib/assets/icons/ic_profile_mock_white.png',
            width: 24.w,
            height: 24.h,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
