import 'package:Krishivani/feature/market/data/datasource/market_api_datasource.dart';
import 'package:Krishivani/feature/market/data/datasource/market_repository.dart';
import 'package:Krishivani/feature/market/providers/market_notifier.dart';
import 'package:Krishivani/feature/market/providers/market_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final marketApiDatasourceProvider =
Provider<MarketApiDatasource>((ref) {
  return MarketApiDatasource();
});

final marketRepositoryProvider =
Provider<MarketRepository>((ref) {
  return MarketRepository(
    ref.read(
      marketApiDatasourceProvider,
    ),
  );
});

final marketProvider =
StateNotifierProvider<
    MarketNotifier,
    MarketState>(
      (ref) {
    return MarketNotifier(
      ref.read(
        marketRepositoryProvider,
      ),
    );
  },
);