import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_history_remote_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/repositories/diagnosis_history_repository.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_notifier.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final diagnosisHistoryDatasourceProvider =
Provider<DiagnosisHistoryRemoteDatasource>((ref) {
  return DiagnosisHistoryRemoteDatasource(
    supabase: Supabase.instance.client,
  );
});

final diagnosisHistoryRepositoryProvider =
Provider<DiagnosisHistoryRepository>((ref) {
  return DiagnosisHistoryRepository(
    ref.read(diagnosisHistoryDatasourceProvider),
  );
});

final diagnosisHistoryProvider = StateNotifierProvider<
    DiagnosisHistoryNotifier,
    DiagnosisHistoryState>(
      (ref) {
    return DiagnosisHistoryNotifier(
      ref.read(diagnosisHistoryRepositoryProvider),
    );
  },
);