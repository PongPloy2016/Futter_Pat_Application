import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String text;
  final String time;
  final bool isSender;

  const ChatMessageEntity({
    required this.text,
    required this.time,
    required this.isSender,
  });

  @override
  List<Object?> get props => [text, time, isSender];
}
