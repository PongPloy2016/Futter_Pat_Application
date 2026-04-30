import '../entities/document_entity.dart';

abstract class AttachFileRepository {
  Future<List<DocumentEntity>> pickDocuments();
}
