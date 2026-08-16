import 'package:Krishivani/feature/chat/data/datasources/chat_api_datasource.dart';
import 'package:Krishivani/feature/chat/data/datasources/chat_remote_datasource.dart';
import 'package:Krishivani/feature/chat/data/repositories/chat_repository.dart';
import 'package:Krishivani/feature/chat/providers/chat_conversation_notifier.dart';
import 'package:Krishivani/feature/chat/providers/chat_notifier.dart';
import 'package:Krishivani/feature/chat/providers/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final chatDatasourceProvider =
Provider<ChatRemoteDatasource>((ref) {
  return ChatRemoteDatasource(
    supabase: Supabase.instance.client,
  );
});

final chatApiDatasourceProvider =
Provider<ChatApiDatasource>((ref) {
  return ChatApiDatasource();
});

final chatRepositoryProvider =
Provider<ChatRepository>((ref) {
  return ChatRepository(
    ref.read(chatDatasourceProvider),
    ref.read(chatApiDatasourceProvider),
  );
});

final chatProvider =
StateNotifierProvider<
    ChatNotifier,
    ChatState>(
      (ref) {
    return ChatNotifier(
      ref.read(chatRepositoryProvider),
    );
  },
);

final chatConversationProvider =
StateNotifierProvider.family<
    ChatConversationNotifier,
    ChatConversationState,
    ChatConversationArgs>(
      (ref, args) {
    final notifier =
    ChatConversationNotifier(
      ref.read(chatRepositoryProvider),
    );

    Future.microtask(
          () => notifier.loadConversation(args),
    );

    return notifier;
  },
);