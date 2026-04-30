import 'package:file_picker/file_picker.dart';

abstract class AttachFileLocalDataSource {
  Future<List<PlatformFile>> pickFiles();
}

class AttachFileLocalDataSourceImpl implements AttachFileLocalDataSource {
  @override
  Future<List<PlatformFile>> pickFiles() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files;
    }
    return [];
  }
}
