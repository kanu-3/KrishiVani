import 'package:Krishivani/feature/chat/data/models/chat_room_model.dart';
import 'package:Krishivani/feature/chat/data/repositories/chat_repository.dart';
import 'package:Krishivani/feature/chat/providers/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatConversationNotifier
    extends StateNotifier<ChatConversationState> {
  final ChatRepository repository;

  ChatConversationNotifier(this.repository)
      : super(
    const ChatConversationState(),
  );

  Future<void> loadConversation(
      ChatConversationArgs args,
      ) async {
    if (args.roomId == null) {
      state = state.copyWith(
        isLoading: false,
        diagnosisId: args.diagnosisId,
        clearError: true,
      );

      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final room =
      await repository.getRoomById(
        args.roomId!,
      );

      final messages =
      await repository.getMessages(
        args.roomId!,
      );

      state = state.copyWith(
        room: room,
        messages: messages,
        diagnosisId: room.diagnosisId,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      print(
        'CHAT LOAD ERROR: $e',
      );

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<ChatRoomModel> createRoomForFirstMessage({
    required String message,
    String? diagnosisId,
    Map<String, dynamic>? diagnosis,
  }) async {
    String title;

    if (diagnosisId != null) {
      final crop =
      diagnosis?['crop']?.toString();

      final disease =
      diagnosis?['disease']?.toString();

      if (crop != null &&
          crop.isNotEmpty &&
          disease != null &&
          disease.isNotEmpty) {
        title = '$crop - $disease';
      } else if (disease != null &&
          disease.isNotEmpty) {
        title = disease;
      } else {
        title = 'Diagnosis chat';
      }
    }

    else {
      title = message.length > 50
          ? '${message.substring(0, 50)}...'
          : message;
    }

    print(
      'CHAT: creating room with title = $title',
    );

    final room =
    await repository.createChatRoom(
      diagnosisId: diagnosisId,
      title: title,
    );

    state = state.copyWith(
      room: room,
      diagnosisId: diagnosisId,
    );

    return room;
  }

  Future<void> sendMessage({
    required String message,
  }) async {
    final text = message.trim();

    if (text.isEmpty ||
        state.isSending) {
      return;
    }

    state = state.copyWith(
      isSending: true,
      clearError: true,
    );

    try {

      final diagnosisId =
          state.room?.diagnosisId ??
              state.diagnosisId;

      print(
        'CHAT FLOW: diagnosisId = $diagnosisId',
      );

      Map<String, dynamic>? diagnosis;

      if (diagnosisId != null) {
        diagnosis =
        await repository.getDiagnosisContext(
          diagnosisId,
        );
      }

      print(
        'CHAT FLOW: diagnosis = $diagnosis',
      );

      String roomId;

      if (state.room == null) {
        print(
          'CHAT FLOW: creating room for first message',
        );

        final room =
        await createRoomForFirstMessage(
          message: text,
          diagnosisId: diagnosisId,
          diagnosis: diagnosis,
        );

        roomId = room.id;

        print(
          'CHAT FLOW: new room = $roomId',
        );
      } else {
        roomId = state.room!.id;
      }

      print(
        'CHAT FLOW: saving user message',
      );

      final userMessage =
      await repository.addMessage(
        chatRoomId: roomId,
        role: 'user',
        message: text,
      );

      print(
        'CHAT FLOW: user message saved = '
            '${userMessage.id}',
      );

      state = state.copyWith(
        messages: [
          ...state.messages,
          userMessage,
        ],
      );

      print(
        'CHAT FLOW: calling /chat',
      );

      final answer =
      await repository.sendChatMessage(
        message: text,
        diagnosis: diagnosis,
      );

      print(
        'CHAT FLOW: answer received = $answer',
      );

      print(
        'CHAT FLOW: saving assistant message',
      );

      final assistantMessage =
      await repository.addMessage(
        chatRoomId: roomId,
        role: 'assistant',
        message: answer,
      );

      state = state.copyWith(
        messages: [
          ...state.messages,
          assistantMessage,
        ],
        isSending: false,
        clearError: true,
      );

      print(
        'CHAT FLOW: complete',
      );
    } catch (e, stackTrace) {
      print(
        'CHAT CONVERSATION ERROR: $e',
      );

      print(
        'CHAT CONVERSATION STACK: $stackTrace',
      );

      state = state.copyWith(
        isSending: false,
        error: e.toString(),
      );
    }
  }
}