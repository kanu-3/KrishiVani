import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/voice_input_button.dart';
import 'package:Krishivani/core/widgets/common/app_empty_widget.dart';
import 'package:Krishivani/core/widgets/common/app_image_carousel.dart';
import 'package:Krishivani/core/widgets/common/app_section_header.dart';
import 'package:Krishivani/core/widgets/navigation/app_search_bar.dart';
import 'package:Krishivani/feature/home/presentation/widgets/home_header.dart';
import 'package:Krishivani/feature/profile/providers/proflie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(profileProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    final name = profile?.name.isNotEmpty == true
        ? profile!.name
        : 'Farmer';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            context.spacingL,
            context.spacingL,
            context.spacingL,
            context.spacingL * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                name: name,
                avatarUrl: profile?.avatarUrl,
                onProfileTap: () {
                  context.go(RoutePaths.profile);
                },
                onNotificationTap: () {},
              ),

              SizedBox(height: context.spacingL),

              AppSearchBar(
                hintText: 'Search plants, diseases, markets...',
                readOnly: true,
                onTap: () {},
              ),

              SizedBox(height: context.spacingL),

              AppImageCarousel(
                images: const [],
                height: context.scaleH(210),
                borderRadius: context.borderRadiusM,
              ),

              SizedBox(height: context.spacingM),

              VoiceInputButton(
                onPressed: () {
                  context.go(RoutePaths.chat);
                },
              ),

              SizedBox(height: context.spacingL),

              AppSectionHeader(
                title: 'Recent Diagnoses',
                actionText: 'View all',
                onTap: () {
                  context.go(RoutePaths.history);
                },
              ),

              SizedBox(height: context.spacingM),

              SizedBox(
                height: context.scaleH(160),
                child: AppEmptyWidget(title: '', subtitle: '',),
              ),

              SizedBox(height: context.spacingL),

              AppSectionHeader(
                title: 'Market Updates',
                actionText: 'View all',
                onTap: () {
                  context.go(RoutePaths.market);
                },
              ),

              SizedBox(height: context.spacingM),

              SizedBox(
                height: context.scaleH(160),
                child: AppEmptyWidget(title: '', subtitle: '',),
              ),

              SizedBox(height: context.spacingL),

              AppSectionHeader(
                title: 'Your Plants',
                actionText: 'View all',
                onTap: () {},
              ),

              SizedBox(height: context.spacingM),

              SizedBox(
                height: context.scaleH(160),
                child: AppEmptyWidget(title: '', subtitle: '',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
