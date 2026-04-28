import 'package:flutter_pat_application/features/shared/data/models/notification/notification_service_model.dart';
import 'package:flutter_pat_application/features/shared/data/models/propertyItemModel/property_Item_model.dart';
import 'package:flutter_pat_application/shared/widgets/main/mainListItem.dart';
import 'package:flutter_pat_application/shared/widgets/notifications/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final notificationList = List<NotificationMobile>.generate(
    10,
    (index) => NotificationMobile(
      id: index,
      toUserId: index + 1,
      title: 'การแจ้งเตือน $index',
      context: 'รายละเอียดการแจ้งเตือน $index',
      isRead: index % 2 == 0, // ตัวอย่างการกำหนดสถานะการอ่าน
      createdDate: '2023-10-01',
      sentDate: '2023-10-01',
      effectiveDate: '2023-10-01',
      fromUser: 'ผู้ส่ง $index',
      notifyType: 'ประเภท $index',
      resourceId: index + 100,
      fileCode: null, // ตัวอย่างที่ไม่มีไฟล์แนบ
      refLink: null, // ตัวอย่างที่ไม่มีลิงก์อ้างอิง
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // จำนวนแท็บ
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(color: Colors.black),
          title: Text('การแจ้งเตือน', style: TextStyle(color: Colors.black)),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Card(
              color: Colors.white,
              elevation: 10,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: TabBar(
                dragStartBehavior: DragStartBehavior.values.last ,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                tabs: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        //border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Tab(text: 'ทั้งหมด')),

                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                     //   border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Tab(text: 'การสร้าง')),

                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                     //   border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Tab(text: 'การสร้าง')),
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                     //   border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Tab(text: 'การสร้าง'))
                
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              itemCount: notificationList.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                return NotificationsItem(
                  item: notificationList[index] ,
                  onlickTap: () {
                    // Action when the item is tapped
                    print("Tapped on notification: ${notificationList[index]}");
                  },
                 // เพิ่ม subtitle ถ้ามี
                );
              },
            ),
            Center(child: Text('แท็บการสร้าง')),
          ],
        ),
      ),
    );
  }
}
