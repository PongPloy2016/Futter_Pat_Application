import '../entities/chat_message_entity.dart';

abstract class CommunicationRepository {
  Future<List<ChatMessageEntity>> getMessages();
  Future<void> sendMessage(ChatMessageEntity message);
}
