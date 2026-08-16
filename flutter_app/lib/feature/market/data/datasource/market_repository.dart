import 'package:Krishivani/feature/market/data/datasource/market_api_datasource.dart';

import '../models/market_forecast_model.dart';

class MarketRepository {
  final MarketApiDatasource apiDatasource;

  MarketRepository(
      this.apiDatasource,
      );

  Future<MarketForecastModel> getMarketForecast() {
    return apiDatasource.getMarketForecast();
  }
}