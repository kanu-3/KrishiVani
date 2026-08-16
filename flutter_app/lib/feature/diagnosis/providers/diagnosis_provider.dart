import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_persistence_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_remote_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_storage_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/repositories/diagnosis_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'diagnosis_notifier.dart';
import 'diagnosis_state.dart';

final diagnosisRemoteDatasourceProvider =
Provider<DiagnosisRemoteDatasource>((ref) {
  return DiagnosisRemoteDatasource();
});

final diagnosisStorageDatasourceProvider =
Provider<DiagnosisStorageDatasource>((ref) {
  return DiagnosisStorageDatasource(
    supabase: Supabase.instance.client,
  );
});

final diagnosisPersistenceDatasourceProvider =
Provider<DiagnosisPersistenceDatasource>((ref) {
  return DiagnosisPersistenceDatasource(
    supabase: Supabase.instance.client,
    storageDatasource: ref.read(
      diagnosisStorageDatasourceProvider,
    ),
  );
});

final diagnosisRepositoryProvider =
Provider<DiagnosisRepository>((ref) {
  return DiagnosisRepository(
    remoteDatasource: ref.read(
      diagnosisRemoteDatasourceProvider,
    ),
    persistenceDatasource: ref.read(
      diagnosisPersistenceDatasourceProvider,
    ),
  );
});

final diagnosisProvider =
StateNotifierProvider<DiagnosisNotifier, DiagnosisState>(
      (ref) {
    return DiagnosisNotifier(
      ref.read(diagnosisRepositoryProvider),
    );
  },
);