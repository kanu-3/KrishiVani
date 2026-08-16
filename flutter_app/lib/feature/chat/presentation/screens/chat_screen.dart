import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_outline_button.dart';
import 'package:Krishivani/core/widgets/common/app_empty_widget.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatScreen
    extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  ConsumerState<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(chatProvider.notifier)
          .loadRooms();
    });
  }

  void _startNewChat() {
    context.push(
      '${RoutePaths.chat}/new',
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final state = ref.watch(
      chatProvider,
    );

    return Scaffold(
      appBar: const AppHeader(
        title: 'Chat',
        showBackButton: false,
      ),
      body: state.isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : state.error != null
          ? Center(
        child: Padding(
          padding:
          context.bodypad,
          child: Text(
            state.error!,
            textAlign:
            TextAlign.center,
          ),
        ),
      )
          : Column(
        children: [
          Padding(
            padding:
            context.bodypad,
            child: AppOutlineButton(
              text:
              'Start New Chat',
              onPressed:
              _startNewChat,
            ),
          ),

          Expanded(
            child:
            state.rooms.isEmpty
                ? const AppEmptyWidget(
              title:
              'No conversations yet',
              subtitle:
              'Start a new conversation with Vanni AI.',
            )
                : RefreshIndicator(
              onRefresh:
                  () {
                return ref
                    .read(
                  chatProvider
                      .notifier,
                )
                    .refresh();
              },
              child:
              ListView.separated(
                padding:
                context.bodypad,
                itemCount:
                state.rooms.length,
                separatorBuilder:
                    (
                    _,
                    __,
                    ) =>
                context
                    .gapS,
                itemBuilder:
                    (
                    context,
                    index,
                    ) {
                  final room =
                  state.rooms[
                  index];

                  return ListTile(
                    title: Text(
                      room.title ??
                          'New conversation',
                    ),
                    subtitle:
                    room.diagnosisId !=
                        null
                        ? const Text(
                      'Diagnosis chat',
                    )
                        : const Text(
                      'General chat',
                    ),
                    trailing:
                    const Icon(
                      AssetPaths
                          .forward,
                      color:
                      AppColors
                          .primaryA,
                    ),
                    onTap: () {
                      context.push(
                        '${RoutePaths.chat}/${room.id}',
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}