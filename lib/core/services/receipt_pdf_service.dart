import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptPdfService {
  static Future<String> generatePdfFile() async {
    try {
      final Uint8List bytes = await generatePdf();
      final String path = await savePdfFile(bytes);

      // สั่งแชร์ไฟล์ทันทีหลังบันทึก
      await Share.shareXFiles(
        [XFile(path)],
        text: 'ดูใบเสร็จรับเงินของคุณ',
      );

      return path;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> savePdfFile(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/Receipt_INV-2026-0001.pdf';
    final File file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    return path;
  }

  static Future<Uint8List> generatePdf() async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();

    // 🎨 1. กำหนดสีตามธีมแอป
    final PdfColor bgColor = PdfColor(248, 249, 251); // สีพื้นหลังหน้าจอ
    final PdfColor cardColor = PdfColor(255, 255, 255); // สีขาวของการ์ด
    final PdfColor sectionColor =
        PdfColor(235, 246, 255); // สีฟ้าอ่อนใน Section
    final PdfColor primaryBlue = PdfColor(0, 154, 219); // สีน้ำเงินหลัก

    // 📄 2. วาดพื้นหลังหน้ากระดาษ (Background)
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(bgColor),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
    );

    // 🗂️ 3. วาดการ์ดหลัก (Main Card)
    final double cardPadding = 20;
    final Rect cardBounds = Rect.fromLTWH(
      cardPadding,
      20,
      pageSize.width - (cardPadding * 2),
      pageSize.height - 80,
    );

    // วาดเงาเล็กน้อย (จำลอง)
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(184, 190, 217)),
      bounds: cardBounds.translate(2, 2),
    );
    // วาดตัวการ์ดสีขาว
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(cardColor),
      bounds: cardBounds,
    );

    // 🖊️ 4. โหลดฟอนต์ภาษาไทย
    final fontData =
        await rootBundle.load('lib/assets/fonts/Kanit/Kanit-Regular.ttf');
    final boldFontData =
        await rootBundle.load('lib/assets/fonts/Kanit/Kanit-Bold.ttf');
    final font = PdfTrueTypeFont(fontData.buffer.asUint8List(), 12);
    final boldFont = PdfTrueTypeFont(boldFontData.buffer.asUint8List(), 14);
    final titleFont = PdfTrueTypeFont(boldFontData.buffer.asUint8List(), 22);

    double currentY = 50;
    final double contentWidth = cardBounds.width - 40;
    final double contentLeft = cardBounds.left + 20;

    // 🔥 วาดชื่อเอกสาร (Title)
    page.graphics.drawString(
      'ใบเสร็จค่าเช่า',
      titleFont,
      brush: PdfSolidBrush(PdfColor(34, 34, 34)),
      bounds: Rect.fromLTWH(contentLeft, currentY, contentWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );
    currentY += 35;

    page.graphics.drawString(
      'เลขที่เอกสาร : INV-2026-0001  ออกวันที่ 11 กุมภาพันธ์ 2569',
      font,
      brush: PdfSolidBrush(PdfColor(136, 136, 136)),
      bounds: Rect.fromLTWH(contentLeft, currentY, contentWidth, 20),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );
    currentY += 40;

    // 🔷 ข้อมูลลูกค้า (Customer Section)
    final PdfGrid customerGrid = PdfGrid();
    customerGrid.columns.add(count: 2);
    customerGrid.columns[0].width = 100;

    _addGridRow(customerGrid, 'รหัสลูกหนี้', '2101/2569', boldFont, font);
    _addGridRow(customerGrid, 'ชื่อ-นามสกุล', 'นายสมใจ ใจดี', boldFont, font);
    _addGridRow(customerGrid, 'ที่อยู่',
        '476/97 หมู่ 8 ต.ในเมือง เมืองราชบุรี\nราชบุรี 74557', boldFont, font);

    customerGrid.style.cellPadding = PdfPaddings(left: 10, top: 10, bottom: 10);
    customerGrid.style.backgroundBrush = PdfSolidBrush(sectionColor);
    // ซ่อนเส้นขอบตารางเพื่อให้ดูเหมือนกล่องมนๆ
    customerGrid.style.borderOverlapStyle = PdfBorderOverlapStyle.inside;

    PdfLayoutResult result = customerGrid.draw(
      page: page,
      bounds: Rect.fromLTWH(contentLeft, currentY, contentWidth, 0),
    )!;
    currentY = result.bounds.bottom + 20;

    // 🔷 รายละเอียดการชำระ (Payment Section)
    final PdfGrid paymentGrid = PdfGrid();
    paymentGrid.columns.add(count: 2);
    paymentGrid.columns[0].width = 100;

    _addGridRow(paymentGrid, 'ทรัพย์สิน', 'A-101 แปลง 12', boldFont, font);
    _addGridRow(paymentGrid, 'รอบบิล', 'มกราคม 2569', boldFont, font);
    _addGridRow(
        paymentGrid, 'วันที่ชำระ', '10 กุมภาพันธ์ 2569', boldFont, font);
    _addGridRow(paymentGrid, 'ค่าเช่า', '15,000 บาท', boldFont, font);
    _addGridRow(paymentGrid, 'ค่าปรับ', '150 บาท', boldFont, font);

    paymentGrid.style.cellPadding = PdfPaddings(left: 10, top: 10, bottom: 10);
    paymentGrid.style.backgroundBrush = PdfSolidBrush(sectionColor);

    paymentGrid.draw(
      page: page,
      bounds: Rect.fromLTWH(contentLeft, currentY, contentWidth, 0),
    );

    // บันทึกไฟล์
    final List<int> bytes = await document.save();
    document.dispose();
    return Uint8List.fromList(bytes);
  }

  static void _addGridRow(PdfGrid grid, String label, String value,
      PdfFont labelFont, PdfFont valueFont) {
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = label;
    row.cells[0].style.font = labelFont;
    row.cells[0].style.borders.all = PdfPens.transparent;
    row.cells[1].value = value;
    row.cells[1].style.font = valueFont;
    row.cells[1].style.borders.all = PdfPens.transparent;
  }
}
