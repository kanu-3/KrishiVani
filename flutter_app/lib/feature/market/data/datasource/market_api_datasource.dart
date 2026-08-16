import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/market_forecast_model.dart';

class MarketApiDatasource {
  static const String baseUrl =
      'http://127.0.0.1:8000';

  Future<MarketForecastModel> getMarketForecast() async {
    final uri = Uri.parse(
      '$baseUrl/market/forecast',
    );

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final responseBody = response.body;

    print(
      'MARKET API STATUS: ${response.statusCode}',
    );

    print(
      'MARKET API BODY: $responseBody',
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Market API failed '
            '(${response.statusCode}): $responseBody',
      );
    }

    final decoded =
    jsonDecode(responseBody)
    as Map<String, dynamic>;

    return MarketForecastModel.fromMap(
      decoded,
    );
  }
}