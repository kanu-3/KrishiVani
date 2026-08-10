import 'package:Krishivani/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required UserModel user,
  });

  Future<AuthResponse> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String newPassword);

  Future<UserModel?> getCurrentUserProfile();

  Future<bool> profileExists();

  Future<void> createUserProfileFromMetadata();

  User? getCurrentUser();
}