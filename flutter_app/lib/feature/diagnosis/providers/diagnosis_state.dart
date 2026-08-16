import 'dart:typed_data';
import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_model.dart';

class DiagnosisState {
  final Uint8List? imageBytes;
  final DiagnosisModel? diagnosis;
  final String? diagnosisId;
  final bool isLoading;
  final String? error;

  const DiagnosisState({
    this.imageBytes,
    this.diagnosis,
    this.diagnosisId,
    this.isLoading = false,
    this.error,
  });
}