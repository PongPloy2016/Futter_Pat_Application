import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/communication_repository.dart';
import '../datasources/communication_remote_datasource.dart';
import '../models/chat_message_model.dart';

class CommunicationRepositoryImpl implements CommunicationRepository {
  final CommunicationRemoteDataSource remoteDataSource;

  CommunicationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ChatMessageEntity>> getMessages() async {
    return await remoteDataSource.getMessages();
  }

  @override
  Future<void> sendMessage(ChatMessageEntity message) async {
    final model = ChatMessageModel.fromEntity(message);
    await remoteDataSource.sendMessage(model);
  }
}
