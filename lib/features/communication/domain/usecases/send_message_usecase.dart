import '../entities/chat_message_entity.dart';
import '../repositories/communication_repository.dart';

class SendMessageUseCase {
  final CommunicationRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> execute(ChatMessageEntity message) async {
    return await repository.sendMessage(message);
  }
}
