import '../data/models/chat_message_model.dart';
import '../data/models/chat_room_model.dart';

class ChatState {
  final List<ChatRoomModel> rooms;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.rooms = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatRoomModel>? rooms,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return ChatState(
      rooms: rooms ?? this.rooms,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class ChatConversationState {
  final ChatRoomModel? room;
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final bool isSending;
  final String? error;
  final String? diagnosisId;

  const ChatConversationState({
    this.room,
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.error,
    this.diagnosisId,
  });

  ChatConversationState copyWith({
    ChatRoomModel? room,
    List<ChatMessageModel>? messages,
    bool? isLoading,
    bool? isSending,
    String? error,
    String? diagnosisId,
    bool clearError = false,
  }) {
    return ChatConversationState(
      room: room ?? this.room,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: clearError ? null : error ?? this.error,
      diagnosisId: diagnosisId ?? this.diagnosisId,
    );
  }
}

class ChatConversationArgs {
  final String? roomId;
  final String? diagnosisId;

  const ChatConversationArgs({
    this.roomId,
    this.diagnosisId,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChatConversationArgs &&
            other.roomId == roomId &&
            other.diagnosisId == diagnosisId;
  }

  @override
  int get hashCode =>
      Object.hash(roomId, diagnosisId);
}