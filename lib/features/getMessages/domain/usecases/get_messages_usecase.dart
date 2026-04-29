import '../entities/chat_message_entity.dart';
import '../repositories/communication_repository.dart';

class GetMessagesUseCase {
  final CommunicationRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<ChatMessageEntity>> execute() async {
    return await repository.getMessages();
  }
}
