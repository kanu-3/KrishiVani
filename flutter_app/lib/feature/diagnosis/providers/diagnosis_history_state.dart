import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_history_model.dart';

class DiagnosisHistoryState {
  final List<DiagnosisHistoryModel> diagnoses;
  final bool isLoading;
  final String? error;

  const DiagnosisHistoryState({
    this.diagnoses = const [],
    this.isLoading = false,
    this.error,
  });

  DiagnosisHistoryState copyWith({
    List<DiagnosisHistoryModel>? diagnoses,
    bool? isLoading,
    String? error,
  }) {
    return DiagnosisHistoryState(
      diagnoses: diagnoses ?? this.diagnoses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}