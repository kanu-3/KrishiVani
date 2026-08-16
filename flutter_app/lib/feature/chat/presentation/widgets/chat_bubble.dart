import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? AppColors.primaryA
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(
              isUser ? 18 : 4,
            ),
            bottomRight: Radius.circular(
              isUser ? 4 : 18,
            ),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: isUser
                ? AppColors.whitetext
                : Theme.of(context)
                .colorScheme
                .onSurface,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}