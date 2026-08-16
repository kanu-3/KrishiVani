import 'package:Krishivani/feature/market/data/models/market_forecast_model.dart';

class MarketState {
  final MarketForecastModel? forecast;
  final bool isLoading;
  final bool isRegenerating;
  final String? error;

  const MarketState({
    this.forecast,
    this.isLoading = false,
    this.isRegenerating = false,
    this.error,
  });

  MarketState copyWith({
    MarketForecastModel? forecast,
    bool? isLoading,
    bool? isRegenerating,
    String? error,
    bool clearForecast = false,
    bool clearError = false,
  }) {
    return MarketState(
      forecast: clearForecast
          ? null
          : forecast ?? this.forecast,
      isLoading:
      isLoading ?? this.isLoading,
      isRegenerating:
      isRegenerating ?? this.isRegenerating,
      error: clearError
          ? null
          : error ?? this.error,
    );
  }
}