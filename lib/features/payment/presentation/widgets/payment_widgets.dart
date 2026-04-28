import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../domain/entities/payment_entity.dart';

import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

/// Card แสดง QR Code สำหรับชำระเงิน
class PaymentQrCodeCard extends StatefulWidget {
  final PaymentEntity data;
  final String Function(double) formatNumber;

  const PaymentQrCodeCard({
    super.key,
    required this.data,
    required this.formatNumber,
  });

  @override
  State<PaymentQrCodeCard> createState() => _PaymentQrCodeCardState();
}

class _PaymentQrCodeCardState extends State<PaymentQrCodeCard> {
  final GlobalKey _qrKey = GlobalKey();

  Future<void> _saveQrCode() async {
    try {
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes != null) {
        // Request permissions if needed
        final hasAccess = await Gal.hasAccess();
        if (!hasAccess) {
          await Gal.requestAccess();
        }
        
        await Gal.putImageBytes(pngBytes, name: "QR_Payment_${DateTime.now().millisecondsSinceEpoch}");

        Fluttertoast.showToast(
          msg: "บันทึกรูปภาพเรียบร้อยแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาดในการบันทึก",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAAAACC).withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          Text(
            'คิวอาร์โค้ดเพื่อชำระเงินผ่านแอปพลิเคชันธนาคารเท่านั้น',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
              fontFamily: 'Kanit',
            ),
          ),
          SizedBox(height: 16.h),
          RepaintBoundary(
            key: _qrKey,
            child: Container(
              height: 200.h,
              width: 200.h,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: SfBarcodeGenerator(
                value: widget.data.qrCodeData,
                symbology: QRCode(
                  errorCorrectionLevel: ErrorCorrectionLevel.high,
                ),
                showValue: false,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'ยอดชำระทั้งหมด',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontFamily: 'Kanit',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${widget.formatNumber(widget.data.totalAmount)} บาท',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: 'Kanit',
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 140.w,
            height: 44.h,
            child: ElevatedButton(
              onPressed: _saveQrCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009ADB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 2,
              ),
              child: Text(
                'บันทึก',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Card แสดงข้อมูลธนาคาร
class PaymentBankInfoCard extends StatelessWidget {
  const PaymentBankInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAAAACC).withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF009ADB).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance,
              color: const Color(0xFF009ADB),
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ธนาคารกรุงไทย',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF009ADB),
                  fontFamily: 'Kanit',
                ),
              ),
              Text(
                'KRUNGTHAI BANK',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF009ADB),
                  fontFamily: 'Kanit',
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'ชำระผ่านธนาคารกรุงไทย',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
                fontFamily: 'Kanit',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Row แสดงข้อมูล Label - Value
class PaymentInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const PaymentInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontFamily: 'Kanit',
            ),
          ),
          Text(
            value,
            style:
                valueStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontFamily: 'Kanit',
                ),
          ),
        ],
      ),
    );
  }
}

/// Divider บางๆ สำหรับคั่นแถวข้อมูล
class PaymentDivider extends StatelessWidget {
  const PaymentDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Divider(color: Colors.grey.shade100, height: 1, thickness: 1);
}
