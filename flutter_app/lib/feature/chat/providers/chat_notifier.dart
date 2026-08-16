import 'package:Krishivani/feature/chat/data/models/chat_room_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/chat_repository.dart';
import 'chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatNotifier(this.repository)
      : super(const ChatState());

  Future<void> loadRooms() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final rooms =
      await repository.getChatRooms();

      state = state.copyWith(
        rooms: rooms,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await loadRooms();
  }
}