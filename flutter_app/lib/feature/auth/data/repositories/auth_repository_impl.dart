import 'package:Krishivani/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:Krishivani/feature/auth/data/models/user_model.dart';
import 'package:Krishivani/feature/auth/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required UserModel user,
  }) async {
    return await remoteDatasource.signUp(
      email: email,
      password: password,
      username: user.username,
      name: user.name,
      phone: user.phone,
      address: user.address,
    );
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return remoteDatasource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<void> forgotPassword(String email) {
    return remoteDatasource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String newPassword) {
    return remoteDatasource.resetPassword(newPassword);
  }

  @override
  Future<UserModel?> getCurrentUserProfile() {
    return remoteDatasource.getCurrentUserProfile();
  }

  @override
  Future<bool> profileExists() {
    return remoteDatasource.profileExists();
  }

  @override
  Future<void> createUserProfileFromMetadata() {
    return remoteDatasource.createUserProfileFromMetadata();
  }

  @override
  User? getCurrentUser() {
    return remoteDatasource.getCurrentUser();
  }
}