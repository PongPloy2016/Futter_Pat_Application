import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/appointment/widgets/appointment_widget.dart';

class CustomtitleCustomerAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomtitleCustomerAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.actions,
    required this.onSuccess,
    this.showActions = true,
  });

  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool showActions;
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: AppointmentBackButton(),
      title: CustomText(
        title,
        textAlign: TextAlign.center,
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: fontBold,
              fontSize: fontSize2_Title.sp,
              color: accent,
            ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: actions ??
          (showActions
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => onSuccess.call(),
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: appointmentPrimaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'lib/assets/icons/ic_customer_service.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
