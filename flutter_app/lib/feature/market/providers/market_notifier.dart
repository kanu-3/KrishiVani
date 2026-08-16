import 'package:Krishivani/feature/market/data/datasource/market_repository.dart';
import 'package:Krishivani/feature/market/providers/market_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketNotifier
    extends StateNotifier<MarketState> {
  final MarketRepository repository;

  MarketNotifier(
      this.repository,
      ) : super(
    const MarketState(),
  );

  Future<void> loadForecast() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final forecast =
      await repository.getMarketForecast();

      state = state.copyWith(
        forecast: forecast,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      print(
        'MARKET LOAD ERROR: $e',
      );

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> regenerate() async {
    state = state.copyWith(
      isRegenerating: true,
      clearError: true,
    );

    try {
      final forecast =
      await repository.getMarketForecast();

      state = state.copyWith(
        forecast: forecast,
        isRegenerating: false,
        clearError: true,
      );
    } catch (e) {
      print(
        'MARKET REGENERATE ERROR: $e',
      );

      state = state.copyWith(
        isRegenerating: false,
        error: e.toString(),
      );
    }
  }
}