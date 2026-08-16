import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;
  final ValueChanged<String>? onSubmitted;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isSending,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: context.bodypad,
        child: Container(

          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, -3),
                color: Colors.black.withValues(
                  alpha: 0.06,
                ),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: 'Ask Vanni AI...',
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Material(
                color: AppColors.primaryA,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isSending ? null : onSend,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: isSending
                        ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : Icon(
                      AssetPaths.send,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}