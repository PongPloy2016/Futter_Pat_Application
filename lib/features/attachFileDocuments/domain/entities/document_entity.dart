import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  final String name;
  final int size;
  final String? path;
  final String? extension;
  final dynamic originalFile; // Holds reference to PlatformFile or File if needed later

  const DocumentEntity({
    required this.name,
    required this.size,
    this.path,
    this.extension,
    this.originalFile,
  });

  @override
  List<Object?> get props => [name, size, path, extension];
}
