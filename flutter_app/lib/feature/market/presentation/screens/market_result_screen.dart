import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/market/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../widgets/market_forecast_chart.dart';
import '../widgets/market_forecast_summary.dart';
import '../widgets/market_result_actions.dart';

class MarketResultScreen extends ConsumerStatefulWidget {
  const MarketResultScreen({
    super.key,
  });

  @override
  ConsumerState<MarketResultScreen> createState() {
    return MarketResultScreenState();
  }
}

class MarketResultScreenState
    extends ConsumerState<MarketResultScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(
          () {
        ref
            .read(marketProvider.notifier)
            .loadForecast();
      },
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final state = ref.watch(
      marketProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Market Forecast',
      ),
      body: state.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.error != null &&
          state.forecast == null
          ? Center(
        child: Padding(
          padding: context.bodypad,
          child: Text(
            state.error!,
            textAlign: TextAlign.center,
          ),
        ),
      )
          : state.forecast == null
          ? const Center(
        child: Text(
          'No forecast available.',
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(
          context.spacingL,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              '${state.forecast!.crop[0].toUpperCase()}'
                  '${state.forecast!.crop.substring(1)}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                color: AppColors.blacktext,
                fontWeight:
                FontWeight.w700,
              ),
            ),

            SizedBox(
              height: context.spacingXXS,
            ),

            Text(
              state.forecast!.district,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: AppColors.blacktext
                    .withOpacity(0.6),
              ),
            ),

            SizedBox(
              height: context.spacingL,
            ),

            Text(
              'This week price predictions',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(
                color: AppColors.blacktext,
                fontWeight:
                FontWeight.w600,
              ),
            ),

            SizedBox(
              height: context.spacingM,
            ),

            MarketForecastChart(
              forecast:
              state.forecast!.forecast,
            ),

            SizedBox(
              height: context.spacingL,
            ),

            MarketForecastSummary(
              forecast:
              state.forecast!,
            ),

            SizedBox(
              height: context.spacingL,
            ),

            MarketResultActions(
              isRegenerating:
              state.isRegenerating,
              onSave: () {
                // Save implementation
                // will be added later.
              },
              onRegenerate: () {
                ref
                    .read(
                  marketProvider
                      .notifier,
                )
                    .regenerate();
              },
            ),
          ],
        ),
      ),
    );
  }
}