import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_pat_application/shared/widgets/main/service_menu_item.dart';
import 'package:go_router/go_router.dart';
import '../../../../../router/app_router.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final PageController _pageController = PageController();
  int _currentNewsIndex = 0;

  final List<String> newsItems = [
    "ประกาศการท่าเรือแห่งประเทศไทย เรื่อง ขอเชิญชวนผู้สนใจใช้พื้นที่ในเขตท่าเรือระนอง เนื้อที่จำนวน 10,120 ตารางเมตร",
    "ประกาศการท่าเรือแห่งประเทศไทย เลื่อนการประชาพิจารณ์",
    "ประกาศรับสมัครพนักงานการท่าเรือแห่งประเทศไทย",
    "ประกาศการท่าเรือแห่งประเทศไทย เรื่อง ขอเชิญชวนผู้สนใจใช้พื้นที่ในเขตท่าเรือระนอง เนื้อที่จำนวน 10,120 ตารางเมตร",
    "ประกาศการท่าเรือแห่งประเทศไทย เลื่อนการประชาพิจารณ์",
    "ประกาศรับสมัครพนักงานการท่าเรือแห่งประเทศไทย",
  ];

  final List<Map<String, dynamic>> services = [
    {
      "name": "สัญญา",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_contract.png",
      "routeName": AppRouter.contractList,
    },
    {
      "name": "นัดหมาย",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_clock.png",
      "routeName": AppRouter.appointmentRenewal,
    },
    {
      "name": "ใบแจ้งหนี้",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_money.png",
    },
    {
      "name": "ตรวจสอบ\nสถานะนัดหมาย",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_project-status.png",
    },
    {
      "name": "ใบเสร็จ/ใบกำกับ\nภาษี",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_receipt.png",
    },
    {
      "name": "ประวัติการ\nชำระเงิน",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_transaction_history.png",
    },
    {
      "name": "ประวัติการใช้\nไฟฟ้า",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_eco_house.png",
    },
    {
      "name": "ประวัติการใช้\nน้ำประปา",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_water_tap.png",
    },
    {
      "name": "ประวัติการใช้\nโทรศัพท์",
      "icon": "lib/assets/icons/ic_svg_receipt.svg",
      "iconpng": "lib/assets/icons/ic_phone_call.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFEAF1F6,
      ), // Matches the light blue/gray background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.h),

            // Profile section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE4EC),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF009ADB),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: const Color(0xFF009ADB),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'คุณชุติมา กลิ่นเพชร',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF009ADB),
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // News section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE5EDF4),
                      Colors.white,
                      Color(0xFFE5EDF4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    // Neumorphic shadows from mockup
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 20,
                      offset: const Offset(-10, -10),
                    ),
                    BoxShadow(
                      color: const Color(0xFFAAAACC).withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                    ),
                    BoxShadow(
                      color: const Color(0xFFAAAACC).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(5, 5),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(-5, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ข่าวสาร',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF009ADB),
                        fontFamily: 'Kanit',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 60.h,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentNewsIndex = index;
                          });
                        },
                        itemCount: newsItems.length,
                        itemBuilder: (context, index) {
                          return Text(
                            newsItems[index],
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black87,
                              fontFamily: 'Kanit',
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        newsItems.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentNewsIndex == index
                                ? const Color(
                                    0xFF009ADB,
                                  ) // Primary blue for active
                                : const Color(
                                    0xFFDCE4EC,
                                  ), // Light gray-blue for inactive
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Services title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    width: 4.w,
                    height: 24.h,
                    color: const Color(0xFF009ADB),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'บริการต่าง ๆ',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF009ADB),
                      fontFamily: 'Kanit',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Services Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.9,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final routeName = services[index]['routeName'] as String?;
                  return ServiceMenuItem(
                    name: services[index]['name'],
                    iconpng:
                        services[index]['iconpng'] ??
                        "lib/assets/icons/ic_receipt.png",
                    onTap: () {
                      if (routeName != null) {
                        context.pushNamed(routeName);
                        return;
                      }
                      if (services[index]['name'] == 'สัญญา') {
                        context.pushNamed(AppRouter.contractList);
                      }
                      if (services[index]['name'] == 'นัดหมาย') {
                        context.pushNamed(AppRouter.appointmentRenewal);
                      }
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
