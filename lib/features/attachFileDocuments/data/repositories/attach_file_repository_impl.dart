import '../../domain/entities/document_entity.dart';
import '../../domain/repositories/attach_file_repository.dart';
import '../datasources/attach_file_local_datasource.dart';
import '../models/document_model.dart';

class AttachFileRepositoryImpl implements AttachFileRepository {
  final AttachFileLocalDataSource localDataSource;

  AttachFileRepositoryImpl({required this.localDataSource});

  @override
  Future<List<DocumentEntity>> pickDocuments() async {
    try {
      final platformFiles = await localDataSource.pickFiles();
      return platformFiles
          .map((file) => DocumentModel.fromPlatformFile(file))
          .toList();
    } catch (e) {
      throw Exception('Failed to pick documents: $e');
    }
  }
}
