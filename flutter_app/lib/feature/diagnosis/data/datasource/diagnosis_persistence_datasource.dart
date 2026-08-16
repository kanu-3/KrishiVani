import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/diagnosis_model.dart';
import 'diagnosis_storage_datasource.dart';

class DiagnosisPersistenceDatasource {
  final SupabaseClient supabase;
  final DiagnosisStorageDatasource storageDatasource;

  DiagnosisPersistenceDatasource({
    required this.supabase,
    required this.storageDatasource,
  });

  Future<String> saveDiagnosis({
    required DiagnosisModel diagnosis,
    required Uint8List imageBytes,
    required String inputType,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final diagnosisId = const Uuid().v4();

    String? imageUrl;

    try {
      imageUrl = await storageDatasource.uploadImage(
        diagnosisId: diagnosisId,
        imageBytes: imageBytes,
      );

      final prediction = diagnosis.disease;

      final parts = prediction.split('___');

      final plantName = parts.first;

      final diseaseName = parts.length > 1
          ? parts.sublist(1).join('___')
          : prediction;

      await supabase.from('diagnoses').insert({
        'id': diagnosisId,
        'user_id': user.id,
        'image_url': imageUrl,
        'input_type': inputType,
        'plant_name': plantName,
        'disease_name': diseaseName,
        'confidence': diagnosis.confidence,
        'prediction_json': diagnosis.toMap(),
      });

      return diagnosisId;
    } catch (e) {
      if (imageUrl != null) {
        try {
          await storageDatasource.deleteImage(
            diagnosisId: diagnosisId,
          );
        } catch (_) {}
      }

      throw Exception(
        'Unable to save diagnosis: $e',
      );
    }
  }
}