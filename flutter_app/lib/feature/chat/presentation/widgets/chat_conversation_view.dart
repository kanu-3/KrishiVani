import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/common/app_empty_widget.dart';
import 'package:Krishivani/feature/chat/providers/chat_state.dart';
import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'chat_input.dart';

class ChatConversationView extends StatelessWidget {
  final ChatConversationState state;
  final TextEditingController controller;
  final ScrollController scrollController;
  final VoidCallback onSend;

  const ChatConversationView({
    super.key,
    required this.state,
    required this.controller,
    required this.scrollController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: state.messages.isEmpty
              ? const AppEmptyWidget(
            title: 'Start the conversation',
            subtitle:
            'Ask KrishiVani about your crop, disease, or farming problem.',
          )
              : ListView.builder(
            controller: scrollController,
            padding: context.bodypad,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                message: state.messages[index],
              );
            },
          ),
        ),

        if (state.error != null)
          Padding(
            padding: const EdgeInsets.symmetric(
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
          isSending: state.isSending,
          onSend: onSend,
          onSubmitted: (_) => onSend(),
        ),
      ],
    );
  }
}