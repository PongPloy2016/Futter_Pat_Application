import '../entities/document_entity.dart';
import '../repositories/attach_file_repository.dart';

class PickDocumentsResult {
  final List<DocumentEntity> validDocuments;
  final bool hasOversizedFiles;

  PickDocumentsResult({
    required this.validDocuments,
    required this.hasOversizedFiles,
  });
}

class PickDocumentsUseCase {
  final AttachFileRepository repository;

  PickDocumentsUseCase(this.repository);

  Future<PickDocumentsResult> execute() async {
    final docs = await repository.pickDocuments();
    
    List<DocumentEntity> validDocs = [];
    bool hasOversized = false;

    for (var doc in docs) {
      final fileSizeInMB = doc.size / (1024 * 1024);
      if (fileSizeInMB > 10.0) {
        hasOversized = true;
      } else {
        validDocs.add(doc);
      }
    }

    return PickDocumentsResult(
      validDocuments: validDocs,
      hasOversizedFiles: hasOversized,
    );
  }
}
