import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_outline_button.dart';
import 'package:Krishivani/core/widgets/common/app_horizontal_card_list.dart';
import 'package:Krishivani/core/widgets/common/app_image_carousel.dart';
import 'package:Krishivani/core/widgets/common/app_info_card.dart';
import 'package:Krishivani/core/widgets/common/app_section_header.dart';
import 'package:Krishivani/core/widgets/navigation/app_search_bar.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_history_card.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_provider.dart';
import 'package:Krishivani/feature/home/presentation/widgets/home_header.dart';
import 'package:Krishivani/feature/market/presentation/widgets/market_crop_card.dart';
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
      ref.read(diagnosisHistoryProvider.notifier).loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final historyState = ref.watch(diagnosisHistoryProvider);

    final profile = profileState.profile;

    final name = profile?.name.isNotEmpty == true
        ? profile!.name
        : 'Farmer';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.bodypad,
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
                images: const [
                  'assets/images/home_01.png',
                  'assets/images/home_02.png',
                  'assets/images/home_03.png',
                  'assets/images/home_04.png',
                  'assets/images/home_05.png',
                ],
                height: context.scaleH(330),
                borderRadius: context.borderRadiusM,
              ),

              SizedBox(height: context.spacingM),

              AppOutlineButton(
                onPressed: () {
                  context.go(RoutePaths.chat);
                }, text: 'Voice Input',
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

              if (historyState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (historyState.diagnoses.isEmpty)
                const SizedBox(
                  height: 180,
                  child: Center(
                    child: Text(
                      'No diagnoses yet',
                    ),
                  ),
                )
              else
                AppHorizontalCardList(
                  height: context.scaleH(330),
                  cardWidth: context.scaleW(280),
                  children: historyState.diagnoses
                      .take(5)
                      .map(
                        (diagnosis) => DiagnosisHistoryCard(
                      diagnosis: diagnosis,
                    ),
                  )
                      .toList(),
                ),

              SizedBox(height: context.spacingL),

              AppSectionHeader(
                title: 'Market Rate Highlights',
                actionText: 'View all',
                onTap: () {
                  context.go(RoutePaths.market);
                },
              ),

              SizedBox(height: context.spacingM),

              AppHorizontalCardList(
                height: context.scaleH(152),
                cardWidth: context.scaleW(330),
                children: [
                  MarketCropCard(
                    cropName: 'Tomato',
                    wholesalePrice: 'Wholesale: ₹45/kg',
                    retailPrice: 'Retail: ₹55/kg',
                    image: Image.asset(
                      AssetPaths.tomatoes,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      context.push(
                        '${RoutePaths.market}/result',
                      );
                    },
                  ),

                  MarketCropCard(
                    cropName: 'Onion',
                    wholesalePrice: 'Wholesale: ₹32/kg',
                    retailPrice: 'Retail: ₹40/kg',
                    image: Image.asset(
                      AssetPaths.onion,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      context.go(RoutePaths.market);
                    },
                  ),

                  MarketCropCard(
                    cropName: 'Brinjal',
                    wholesalePrice: 'Wholesale: ₹38/kg',
                    retailPrice: 'Retail: ₹45/kg',
                    image: Image.asset(
                      AssetPaths.brinjal,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      context.go(RoutePaths.market);
                    },
                  ),
                ],
              ),

              SizedBox(height: context.spacingL),

              AppSectionHeader(
                title: 'Tip of the Day',
              ),

              SizedBox(height: context.spacingM),

              const AppInfoCard(
                quote:
                'Regularly inspect your crops for early signs of disease.',
                imageUrl: 'data:image/jpeg;base64,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',
              ),
            ],
          ),
        ),
      ),
    );
  }
}