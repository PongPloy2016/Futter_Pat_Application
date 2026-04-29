import '../models/chat_message_model.dart';

abstract class CommunicationRemoteDataSource {
  Future<List<ChatMessageModel>> getMessages();
  Future<void> sendMessage(ChatMessageModel message);
}

class CommunicationRemoteDataSourceImpl implements CommunicationRemoteDataSource {
  final List<ChatMessageModel> _mockMessages = [
    const ChatMessageModel(
      text: 'เรียน คุณสมชาย\nเจ้าหน้าที่ได้ตรวจสอบเอกสารคำขอต่อสัญญาแล้ว\nพบว่าขาดเอกสารบางรายการ กรุณาแนบเอกสารเพิ่มดังนี้\n • หนังสือมอบอำนาจ\nขอบคุณค่ะ',
      time: '10.30',
      isSender: false,
    ),
    const ChatMessageModel(
      text: 'รับทราบค่ะ',
      time: '11.00',
      isSender: true,
    ),
  ];

  @override
  Future<List<ChatMessageModel>> getMessages() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_mockMessages);
  }

  @override
  Future<void> sendMessage(ChatMessageModel message) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _mockMessages.add(message);
  }
}
