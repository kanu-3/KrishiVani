import 'dart:typed_data';
import 'package:Krishivani/feature/diagnosis/data/repositories/diagnosis_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'diagnosis_state.dart';

class DiagnosisNotifier extends StateNotifier<DiagnosisState> {
  final DiagnosisRepository repository;

  DiagnosisNotifier(this.repository)
      : super(const DiagnosisState());

  Future<void> predict({
    required Uint8List imageBytes,
    required String inputType,
  }) async {
    state = DiagnosisState(
      imageBytes: imageBytes,
      isLoading: true,
    );

    try {
      final result = await repository.predict(
        imageBytes: imageBytes,
        inputType: inputType,
      );

      state = DiagnosisState(
        imageBytes: imageBytes,
        diagnosis: result.diagnosis,
        diagnosisId: result.diagnosisId,
      );
    } catch (e) {
      state = DiagnosisState(
        imageBytes: imageBytes,
        error: e.toString(),
      );
    }
  }

  void setError(String error) {
    state = DiagnosisState(
      imageBytes: state.imageBytes,
      error: error,
    );
  }

  void clear() {
    state = const DiagnosisState();
  }
}