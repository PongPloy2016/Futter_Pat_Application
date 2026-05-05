import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../shared/widgets/appbar/custom_title_customer_app_bar.dart';
import 'package:go_router/go_router.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  final String title;

  const PdfViewerScreen({
    super.key,
    required this.pdfPath,
    this.title = 'ดูตัวอย่างเอกสาร',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomtitleCustomerAppBar(
        title: title,
        onSuccess: () => context.pop(),
        showActions: false,
      ),
      body: SfPdfViewer.file(File(pdfPath)),
    );
  }
}
