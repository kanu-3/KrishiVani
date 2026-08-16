import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/common/app_empty_widget.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/chat/presentation/widgets/chat_bubble.dart';
import 'package:Krishivani/feature/chat/presentation/widgets/chat_input.dart';
import 'package:Krishivani/feature/chat/providers/chat_provider.dart';
import 'package:Krishivani/feature/chat/providers/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatConversationScreen
    extends ConsumerStatefulWidget {
  final String? roomId;
  final String? diagnosisId;

  const ChatConversationScreen({
    super.key,
    this.roomId,
    this.diagnosisId,
  });

  @override
  ConsumerState<ChatConversationScreen> createState() =>
      ChatConversationScreenState();
}

class ChatConversationScreenState
    extends ConsumerState<ChatConversationScreen> {
  final TextEditingController controller =
  TextEditingController();

  final ScrollController scrollController =
  ScrollController();

  late final ChatConversationArgs args;

  @override
  void initState() {
    super.initState();

    args = ChatConversationArgs(
      roomId: widget.roomId,
      diagnosisId: widget.diagnosisId,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = controller.text.trim();

    if (message.isEmpty) {
      return;
    }

    controller.clear();

    final provider =
    chatConversationProvider(args);

    await ref
        .read(provider.notifier)
        .sendMessage(
      message: message,
    );

    if (!mounted) {
      return;
    }

    final state = ref.read(provider);

    if (widget.roomId == null &&
        state.room != null) {
      context.go(
        '${RoutePaths.chat}/${state.room!.id}',
      );

      return;
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (!scrollController.hasClients) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) {
        return;
      }

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      chatConversationProvider(args),
    );

    return Scaffold(
      appBar: AppHeader(
        title: state.room?.title ?? 'Chat',
      ),

      body: state.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: state.messages.isEmpty
                ? const AppEmptyWidget(
              title: 'Ask KrishiVani',
              subtitle:
              'Ask about crop diseases, symptoms, treatment, or farming problems.',
            )
                : ListView.builder(
              controller:
              scrollController,
              padding:
              context.bodypad,
              itemCount:
              state.messages.length,
              itemBuilder:
                  (context, index) {
                return ChatBubble(
                  message:
                  state.messages[index],
                );
              },
            ),
          ),

          if (state.error != null)
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                state.error!,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .error,
                ),
              ),
            ),

          ChatInput(
            controller: controller,
            isSending:
            state.isSending,
            onSend: _sendMessage,
            onSubmitted: (_) =>
                _sendMessage(),
          ),
        ],
      ),
    );
  }
}