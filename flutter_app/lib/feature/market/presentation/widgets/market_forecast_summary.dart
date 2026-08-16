import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/core_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../data/models/market_forecast_model.dart';

class MarketForecastSummary extends StatelessWidget {
  const MarketForecastSummary({
    super.key,
    required this.forecast,
  });

  final MarketForecastModel forecast;

  @override
  Widget build(BuildContext context) {
    final first =
        forecast.forecast.first.predictedPrice;

    final last =
        forecast.forecast.last.predictedPrice;

    final difference = last - first;

    final isIncreasing = difference > 0;

    final trendText = difference == 0
        ? 'Prices are expected to remain stable.'
        : isIncreasing
        ? 'Prices are expected to rise over the forecast period.'
        : 'Prices are expected to fall over the forecast period.';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        context.spacingM,
      ),
      decoration: BoxDecoration(
        color: CoreColors.white,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Vanni AI Suggestion',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
              color: AppColors.blacktext,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(
            height: context.spacingXXS,
          ),

          Text(
            trendText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: AppColors.blacktext,
            ),
          ),

          SizedBox(
            height: context.spacingXS,
          ),

          Text(
            'Day 1: ₹${first.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),

          Text(
            'Day 7: ₹${last.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),
        ],
      ),
    );
  }
}