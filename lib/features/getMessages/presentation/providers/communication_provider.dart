import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

class CommunicationNotifier extends AsyncNotifier<List<ChatMessageEntity>> {
  @override
  Future<List<ChatMessageEntity>> build() async {
    final getMessagesUseCase = sl<GetMessagesUseCase>();
    return await getMessagesUseCase.execute();
  }

  Future<void> sendMessage(String text) async {
    final now = DateTime.now();
    final timeString = '${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')}';
    
    final message = ChatMessageEntity(
      text: text,
      time: timeString,
      isSender: true,
    );

    // Optimistically update the UI
    final previousState = state.value ?? [];
    state = AsyncValue.data([...previousState, message]);

    try {
      final sendMessageUseCase = sl<SendMessageUseCase>();
      await sendMessageUseCase.execute(message);
    } catch (e, st) {
      // Revert if error
      state = AsyncValue.data(previousState);
      state = AsyncValue.error(e, st);
    }
  }
}

final communicationProvider = AsyncNotifierProvider<CommunicationNotifier, List<ChatMessageEntity>>(() {
  return CommunicationNotifier();
});
