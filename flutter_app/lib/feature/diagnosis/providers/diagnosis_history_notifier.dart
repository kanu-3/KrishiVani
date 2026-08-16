import 'package:Krishivani/feature/diagnosis/data/repositories/diagnosis_history_repository.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiagnosisHistoryNotifier
    extends StateNotifier<DiagnosisHistoryState> {
  final DiagnosisHistoryRepository repository;

  DiagnosisHistoryNotifier(this.repository)
      : super(const DiagnosisHistoryState());

  Future<void> loadHistory() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final diagnoses = await repository.getHistory();

      state = state.copyWith(
        diagnoses: diagnoses,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await loadHistory();
  }
}