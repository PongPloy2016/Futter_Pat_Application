import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../widgets/contract_card.dart';

class ScanContractScreen extends StatefulWidget {
  const ScanContractScreen({super.key, this.isBarcodeSelected = true});

  final bool isBarcodeSelected;

  @override
  State<ScanContractScreen> createState() => _ScanContractScreenState();
}

class _ScanContractScreenState extends State<ScanContractScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  Barcode? _result;
  bool _isFlashOn = false;
  late bool _isBarcodeSelected;

  @override
  void initState() {
    super.initState();
    _isBarcodeSelected = widget.isBarcodeSelected;
  }

  // Hot reload support
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    } else if (Platform.isIOS) {
      _controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final isQrCode = scanData.format == BarcodeFormat.qrcode;
      final isValidFormat = _isBarcodeSelected ? !isQrCode : isQrCode;

      if (isValidFormat && _result == null) {
        setState(() {
          _result = scanData;
        });
        // Pause camera after first scan
        controller.pauseCamera();
        // Show result dialog
        _showScanResultDialog(scanData);
      }
    });
  }

  void _showScanResultDialog(Barcode scanData) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: const Color(0xFF009ADB),
              size: 28.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              'สแกนสำเร็จ',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF222222),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ResultInfoRow(
              label: 'ประเภท',
              value: describeEnum(scanData.format),
            ),
            SizedBox(height: 10.h),
            _ResultInfoRow(label: 'ข้อมูล', value: scanData.code ?? '-'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetScanner();
            },
            child: Text(
              'สแกนใหม่',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                color: contractLabelTextColor,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetScanner();
              // Pop back to previous screen with scanned data
              // context.pop(scanData.code);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: contractPrimaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'ยืนยัน',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetScanner() {
    setState(() {
      _result = null;
    });
    _controller?.resumeCamera();
  }

  Future<void> _toggleFlash() async {
    await _controller?.toggleFlash();
    final flashStatus = await _controller?.getFlashStatus();
    setState(() {
      _isFlashOn = flashStatus ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  const ContractBackButton(),
                  SizedBox(height: 28.h),
                  ContractPageTitle(
                    title: _isBarcodeSelected ? 'Scan Barcode' : 'Scan QR Code',
                  ),
                  SizedBox(height: 26.h),
                  Center(
                    child: _ScanTabBar(
                      isBarcodeSelected: _isBarcodeSelected,
                      onTabChanged: (isBarcode) {
                        setState(() {
                          _isBarcodeSelected = isBarcode;
                          _result = null;
                        });
                        _controller?.resumeCamera();
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),

            // Scanner View
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      // QR View
                      QRView(
                        key: _qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderColor: contractPrimaryBlue,
                          borderRadius: 12.r,
                          borderLength: 30.w,
                          borderWidth: 4.w,
                          cutOutSize: _isBarcodeSelected ? 280.w : 250.w,
                          cutOutBottomOffset: _isBarcodeSelected ? 0 : 0,
                        ),
                        formatsAllowed: _isBarcodeSelected
                            ? BarcodeFormat.values
                                .where((f) => f != BarcodeFormat.qrcode)
                                .toList()
                            : const [BarcodeFormat.qrcode],
                      ),

                      // Scan instruction text
                      Positioned(
                        bottom: 24.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              _isBarcodeSelected
                                  ? 'วาง Barcode ในกรอบเพื่อสแกน'
                                  : 'วาง QR Code ในกรอบเพื่อสแกน',
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flash button
                  // _ControlButton(
                  //   icon: _isFlashOn
                  //       ? Icons.flash_on_rounded
                  //       : Icons.flash_off_rounded,
                  //   label: _isFlashOn ? 'ปิดแฟลช' : 'เปิดแฟลช',
                  //   onPressed: _toggleFlash,
                  // ),
                  SizedBox(width: 32.w),
                  // Cancel button
                  ContractPrimaryButton(
                    label: 'ยกเลิก',
                    width: 100,
                    backgroundColor: const Color(0xFFE0E0E0),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanTabBar extends StatelessWidget {
  const _ScanTabBar({
    required this.isBarcodeSelected,
    required this.onTabChanged,
  });

  final bool isBarcodeSelected;
  final ValueChanged<bool> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 226.w,
      height: 34.h,
      decoration: BoxDecoration(
        color: contractPrimaryBlue,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _ScanTab(
            label: 'Barcode',
            selected: isBarcodeSelected,
            onTap: () => onTabChanged(true),
          ),
          _ScanTab(
            label: 'QR Code',
            selected: !isBarcodeSelected,
            onTap: () => onTabChanged(false),
          ),
        ],
      ),
    );
  }
}

class _ScanTab extends StatelessWidget {
  const _ScanTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? contractDarkBlue : contractPrimaryBlue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 16.sp,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: contractPrimaryBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: contractPrimaryBlue, width: 1.5),
            ),
            child: Icon(icon, color: contractPrimaryBlue, size: 24.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 12.sp,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultInfoRow extends StatelessWidget {
  const _ResultInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              color: contractLabelTextColor,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
            ),
          ),
        ),
      ],
    );
  }
}
