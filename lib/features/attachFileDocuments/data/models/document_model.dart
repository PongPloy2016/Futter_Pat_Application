import 'package:file_picker/file_picker.dart';
import '../../domain/entities/document_entity.dart';

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.name,
    required super.size,
    super.path,
    super.extension,
    super.originalFile,
  });

  factory DocumentModel.fromPlatformFile(PlatformFile file) {
    return DocumentModel(
      name: file.name,
      size: file.size,
      path: file.path,
      extension: file.extension,
      originalFile: file,
    );
  }

  PlatformFile get toPlatformFile {
    if (originalFile is PlatformFile) {
      return originalFile as PlatformFile;
    }
    // Fallback if somehow not present (shouldn't happen in our use case)
    return PlatformFile(
      name: name,
      size: size,
      path: path,
    );
  }
}
