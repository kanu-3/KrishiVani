class MarketForecastItemModel {
  final int day;
  final double predictedPrice;

  const MarketForecastItemModel({
    required this.day,
    required this.predictedPrice,
  });

  factory MarketForecastItemModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return MarketForecastItemModel(
      day: map['day'] as int,
      predictedPrice:
      (map['predicted_price'] as num).toDouble(),
    );
  }
}

class MarketForecastModel {
  final String crop;
  final String district;
  final int historicalDaysUsed;
  final String historicalStartDate;
  final String historicalEndDate;
  final int forecastDays;
  final List<MarketForecastItemModel> forecast;

  const MarketForecastModel({
    required this.crop,
    required this.district,
    required this.historicalDaysUsed,
    required this.historicalStartDate,
    required this.historicalEndDate,
    required this.forecastDays,
    required this.forecast,
  });

  factory MarketForecastModel.fromMap(
      Map<String, dynamic> map,
      ) {
    final historicalData =
    map['historical_data'] as Map<String, dynamic>;

    final forecastData =
    map['forecast'] as List;

    return MarketForecastModel(
      crop: map['crop'] as String,
      district: map['district'] as String,
      historicalDaysUsed:
      map['historical_days_used'] as int,
      historicalStartDate:
      historicalData['start_date'] as String,
      historicalEndDate:
      historicalData['end_date'] as String,
      forecastDays:
      map['forecast_days'] as int,
      forecast: forecastData
          .map(
            (item) => MarketForecastItemModel.fromMap(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}