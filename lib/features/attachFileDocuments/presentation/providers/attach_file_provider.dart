import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document_entity.dart';
import '../../domain/usecases/pick_documents_usecase.dart';
import '../../../../core/di/injection.dart';

class AttachFileState {
  final List<DocumentEntity> naturalPersonFiles;
  final List<DocumentEntity> juristicPersonFiles;
  final bool hasOversizedError;

  AttachFileState({
    this.naturalPersonFiles = const [],
    this.juristicPersonFiles = const [],
    this.hasOversizedError = false,
  });

  AttachFileState copyWith({
    List<DocumentEntity>? naturalPersonFiles,
    List<DocumentEntity>? juristicPersonFiles,
    bool? hasOversizedError,
  }) {
    return AttachFileState(
      naturalPersonFiles: naturalPersonFiles ?? this.naturalPersonFiles,
      juristicPersonFiles: juristicPersonFiles ?? this.juristicPersonFiles,
      hasOversizedError: hasOversizedError ?? this.hasOversizedError,
    );
  }
}

class AttachFileNotifier extends StateNotifier<AttachFileState> {
  final PickDocumentsUseCase pickDocumentsUseCase;

  AttachFileNotifier(this.pickDocumentsUseCase) : super(AttachFileState());

  Future<void> pickFiles(bool isNaturalPerson) async {
    final result = await pickDocumentsUseCase.execute();
    
    if (result.validDocuments.isNotEmpty) {
      if (isNaturalPerson) {
        final newFiles = [...state.naturalPersonFiles];
        for (var doc in result.validDocuments) {
          if (!newFiles.any((e) => e.name == doc.name && e.size == doc.size)) {
            newFiles.add(doc);
          }
        }
        state = state.copyWith(
          naturalPersonFiles: newFiles,
          hasOversizedError: result.hasOversizedFiles,
        );
      } else {
        final newFiles = [...state.juristicPersonFiles];
        for (var doc in result.validDocuments) {
          if (!newFiles.any((e) => e.name == doc.name && e.size == doc.size)) {
            newFiles.add(doc);
          }
        }
        state = state.copyWith(
          juristicPersonFiles: newFiles,
          hasOversizedError: result.hasOversizedFiles,
        );
      }
    } else if (result.hasOversizedFiles) {
      state = state.copyWith(hasOversizedError: true);
    }
  }

  void removeFile(bool isNaturalPerson, DocumentEntity file) {
    if (isNaturalPerson) {
      final newFiles = state.naturalPersonFiles.where((e) => e != file).toList();
      state = state.copyWith(naturalPersonFiles: newFiles, hasOversizedError: false);
    } else {
      final newFiles = state.juristicPersonFiles.where((e) => e != file).toList();
      state = state.copyWith(juristicPersonFiles: newFiles, hasOversizedError: false);
    }
  }
  
  void clearError() {
    state = state.copyWith(hasOversizedError: false);
  }
}

final attachFileProvider = StateNotifierProvider<AttachFileNotifier, AttachFileState>((ref) {
  return AttachFileNotifier(sl<PickDocumentsUseCase>());
});
