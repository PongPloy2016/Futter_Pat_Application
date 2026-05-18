import 'package:flutter/material.dart';

extension WidgetBackgroundExtension on Widget {
  // 1. สำหรับพื้นหลัง Gradient เต็มจอ (แบบนิ่งๆ ไม่เลื่อนตามเนื้อหา)
  Widget withLoginBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF03171B), // Very dark teal/black
            Color(0xFF0D2D3E), // Dark blue
            Color(0xFF3892BF), // Light blue
            Color(0xFF75D1F2), // Very light blue at bottom
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: this,
    );
  }

  // 2. สำหรับเนื้อหาที่ต้องการให้อยู่ใน Card สีขาวและ Scroll ได้
  Widget withWhiteCardLayout() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: this,
          ),
        ),
      ),
    );
  }
}
