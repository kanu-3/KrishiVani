import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiDatasource {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<String> sendMessage({
    required String message,
    Map<String, dynamic>? diagnosis,
  }) async {
    final uri = Uri.parse('$baseUrl/chat');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
        'diagnosis': diagnosis,
      }),
    );

    final responseBody = response.body;

    print('CHAT API STATUS: ${response.statusCode}');
    print('CHAT API BODY: $responseBody');

    if (response.statusCode != 200) {
      throw Exception(
        'Chat API failed '
            '(${response.statusCode}): $responseBody',
      );
    }

    final decoded = jsonDecode(responseBody);

    if (decoded['response'] == null) {
      throw Exception(
        'Chat API response does not contain response.',
      );
    }

    return decoded['response'] as String;
  }
}