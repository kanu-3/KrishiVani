import 'package:Krishivani/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/auth_repository_impl.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authRemoteDatasourceProvider =
Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDatasourceProvider),
  );
});

final authNotifierProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(authRepositoryProvider),
  );
});