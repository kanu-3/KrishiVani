class ChatMessageModel {
  final String id;
  final String chatRoomId;
  final String role;
  final String message;
  final DateTime createdAt;

  const ChatMessageModel({
    required this.id,
    required this.chatRoomId,
    required this.role,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessageModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return ChatMessageModel(
      id: map['id'] as String,
      chatRoomId: map['chat_room_id'] as String,
      role: map['role'] as String,
      message: map['message'] as String,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }

  bool get isUser => role == 'user';

  bool get isAssistant => role == 'assistant';
}