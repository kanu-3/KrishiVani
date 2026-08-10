import 'package:Krishivani/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:Krishivani/feature/profile/data/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_notifier.dart';
import 'profile_state.dart';

final profileDatasourceProvider = Provider<ProfileRemoteDatasource>((ref) {
  return ProfileRemoteDatasource(
    Supabase.instance.client,
  );
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(
    ref.read(profileDatasourceProvider),
  );
});

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
    ref.read(profileRepositoryProvider),
  );
});