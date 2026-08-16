import 'dart:convert';
import 'dart:typed_data';
import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosisRemoteDatasource {
  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<DiagnosisModel> predict({
    required Uint8List imageBytes,
  }) async {
    final uri = Uri.parse('$baseUrl/predict');

    final request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: 'plant.jpg',
        contentType: MediaType(
          'image',
          'jpeg',
        ),
      ),
    );

    final response = await request.send();

    final responseBody =
    await response.stream.bytesToString();

    print('STATUS: ${response.statusCode}');
    print('BODY: $responseBody');

    if (response.statusCode != 200) {
      throw Exception(
        'Prediction failed '
            '(${response.statusCode}): $responseBody',
      );
    }

    try {
      final decoded = jsonDecode(responseBody);

      print('DECODED: $decoded');
      print('DISEASE: ${decoded['disease']}');
      print('CONFIDENCE: ${decoded['confidence']}');

      if (decoded['disease'] == null) {
        throw Exception(
          'API response does not contain disease.',
        );
      }

      if (decoded['confidence'] == null) {
        throw Exception(
          'API response does not contain confidence.',
        );
      }

      return DiagnosisModel.fromMap(
        decoded as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(
        'Invalid response from diagnosis API: $e',
      );
    }
  }
}

class DiagnosisQueryDatasource {
  final SupabaseClient supabase;

  DiagnosisQueryDatasource({
    required this.supabase,
  });

  Future<Map<String, dynamic>?> getDiagnosisById(
      String diagnosisId,
      ) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final response = await supabase
        .from('diagnoses')
        .select()
        .eq('id', diagnosisId)
        .eq('user_id', user.id)
        .maybeSingle();

    return response;
  }
}