import 'dart:typed_data';
import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_persistence_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_remote_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_model.dart';

class DiagnosisRepository {
  final DiagnosisRemoteDatasource remoteDatasource;
  final DiagnosisPersistenceDatasource persistenceDatasource;

  DiagnosisRepository({
    required this.remoteDatasource,
    required this.persistenceDatasource,
  });

  Future<({DiagnosisModel diagnosis, String diagnosisId})> predict({
    required Uint8List imageBytes,
    required String inputType,
  }) async {
    final diagnosis = await remoteDatasource.predict(
      imageBytes: imageBytes,
    );

    final diagnosisId = await persistenceDatasource.saveDiagnosis(
      diagnosis: diagnosis,
      imageBytes: imageBytes,
      inputType: inputType,
    );

    return (
    diagnosis: diagnosis,
    diagnosisId: diagnosisId,
    );
  }
}