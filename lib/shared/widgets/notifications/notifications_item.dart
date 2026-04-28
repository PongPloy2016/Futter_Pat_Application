import 'package:flutter_pat_application/features/shared/data/models/notification/notification_service_model.dart';
import 'package:flutter_pat_application/features/shared/data/models/propertyItemModel/property_Item_model.dart';
import 'package:flutter_pat_application/core/theme/colors.dart';
import 'package:flutter/material.dart';

class NotificationsItem extends StatelessWidget {
  final NotificationMobile item;
  final VoidCallback onlickTap;

  const NotificationsItem({required this.item, required this.onlickTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onlickTap(),
      child: Card(
        color: Colors.white,
      //  margin: const EdgeInsets.all(10),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent, // Set the background to be transparent so it doesn't override
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromARGB(255, 85, 49, 49), width: 1),
          ),
          child: Row(
            children: [
              // Left section - Title and description area

              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  //  height: 60,
                   color: Colors.yellow,
                  width: double.infinity, // Make sure the width takes the full space
                  child: Image.asset(
                    fit: BoxFit.fill,
                    "lib/assets/images/bmta_logo_icon_two.png",
                    // width: 80,
                    // height: 80,
                    scale: 1,
                  ),
                  //  SvgPicture.asset(
                  //   menuItem.image,
                  //   height: 40, // Adjust the height as needed
                  //   width: 40,  // Adjust the width as needed
                  //   fit: BoxFit.contain,
                  // ),
                ),
              ),
              SizedBox(width: 10), // Add spacing between left and right sections
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(item.sentDate ?? "", style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    // Text(item.description, style: const TextStyle(color: Colors.grey)),
                    // const SizedBox(height: 8),
                    // Text(item.location, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              // Right section - Count area
            ],
          ),
        ),
      ),
    );
  }
}
