import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../data/models/market_forecast_model.dart';

class MarketForecastChart extends StatelessWidget {
  const MarketForecastChart({
    super.key,
    required this.forecast,
  });

  final List<MarketForecastItemModel> forecast;

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Text(
            'No forecast data available.',
          ),
        ),
      );
    }

    final spots = forecast
        .map(
          (item) => FlSpot(
        item.day.toDouble(),
        item.predictedPrice,
      ),
    )
        .toList();

    final prices = forecast
        .map(
          (item) => item.predictedPrice,
    )
        .toList();

    final minimum =
    prices.reduce(
          (a, b) => a < b ? a : b,
    );

    final maximum =
    prices.reduce(
          (a, b) => a > b ? a : b,
    );

    final range = maximum - minimum;

    final padding = range == 0
        ? 20
        : range * 0.32;

    final chartMinimum = minimum - padding;
    final chartMaximum = maximum + padding;

    return SizedBox(
      height: context.scaleH(320),
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: forecast.length.toDouble(),
          minY: chartMinimum,
          maxY: chartMaximum,

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
          ),

          borderData: FlBorderData(
            show: false,
          ),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: context.scaleW(48),
                getTitlesWidget: (
                    value,
                    meta,
                    ) {
                  return Text(
                    '₹${value.toInt()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (
                    value,
                    meta,
                    ) {
                  return Text(
                    'D${value.toInt()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  );
                },
              ),
            ),
          ),

          lineTouchData: LineTouchData(
            touchTooltipData:
            LineTouchTooltipData(
              getTooltipItems: (
                  touchedSpots,
                  ) {
                return touchedSpots
                    .map(
                      (spot) {
                    return LineTooltipItem(
                      'Day ${spot.x.toInt()}\n'
                          '₹${spot.y.toStringAsFixed(2)}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    );
                  },
                )
                    .toList();
              },
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: context.scale(3),
              color: AppColors.main,
              dotData: FlDotData(
                show: true,
              ),
              belowBarData:
              BarAreaData(
                show: true,
                color: AppColors.main
                    .withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}