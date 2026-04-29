import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.text,
    required super.time,
    required super.isSender,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'] as String,
      time: json['time'] as String,
      isSender: json['isSender'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
      'isSender': isSender,
    };
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      text: entity.text,
      time: entity.time,
      isSender: entity.isSender,
    );
  }
}
