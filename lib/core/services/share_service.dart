import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> sharePdf(String path) async {
    await Share.shareXFiles(
      [XFile(path)],
      text: 'ดูใบเสร็จรับเงินของคุณ',
    );
  }
}
