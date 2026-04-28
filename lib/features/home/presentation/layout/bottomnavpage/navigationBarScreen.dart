import 'package:flutter_pat_application/features/equipment/presentation/screens/equipmentDetail/equipmentDetailScreen.dart';
import 'package:flutter_pat_application/features/equipment/presentation/screens/equipmentList/equipmentListScreen.dart';
import 'package:flutter_pat_application/features/home/presentation/screens/mainPage/main_screen.dart';
import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter_pat_application/core/theme/fontsize.dart';
import 'package:flutter_pat_application/shared/widgets/appbar/custom_drawer_title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_pat_application/shared/widgets/drawer/custom_drawer.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController _tabController;
  final int lengthTap = 3;

  TabController getTabController() {
    return TabController(length: lengthTap, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    _tabController = getTabController();
  }

  @override
  Widget build(BuildContext context) {
    // final t = AppLocalizations.of(context);

    return DefaultTabController(
      length: lengthTap,
      child: Scaffold(
        appBar: const CustomDrawerTitleAppBar(title: ''),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            MainPageScreen(),
            EquipmentDetailScreen(),
            EquipmentDetailScreen(),
          ],
        ),
        drawer: const CustomDrawer(),

        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: vacationLeaveColor,
          unselectedItemColor: vacationLeaveColor,
          selectedLabelStyle: TextStyle(fontSize: fontSize8_Overline.sp),
          unselectedLabelStyle: TextStyle(fontSize: fontSize8_Overline.sp),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: fontSize7_Caption.sp,
          unselectedFontSize: fontSize7_Caption.sp,
          currentIndex: _tabController.index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'lib/assets/icons/fi_home.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(textFromMenu, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                'lib/assets/icons/fi_home.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  vacationLeaveColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'หน้าหลัก',
            ),

            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'lib/assets/icons/ic_user.png',
                width: 24.w,
                height: 24.h,
              ),
              icon: Image.asset(
                'lib/assets/icons/ic_user.png',
                width: 24.w,
                height: 24.h,
              ),
              label: 'โปรไฟล์',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'lib/assets/icons/fi_settings.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(textFromMenu, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                'lib/assets/icons/fi_settings.svg',
                width: 24.w,
                height: 24.h,
              ),
              label: 'ตั้งค่า',
            ),
          ],
        ),
      ),
    );
  }
}
