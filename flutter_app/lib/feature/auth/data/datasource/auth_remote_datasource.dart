import 'package:Krishivani/core/services/supabase_service.dart';
import 'package:Krishivani/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    required String name,
    String? phone,
    String? address,
  });

  Future<AuthResponse> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String newPassword);

  Future<void> createUserProfileFromMetadata();

  Future<bool> profileExists();

  Future<UserModel?> getCurrentUserProfile();

  User? getCurrentUser();

  Stream<AuthState> authStateChanges();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient _client = SupabaseService.client;

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    required String name,
    String? phone,
    String? address,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'name': name,
        'phone': phone,
        'address': address,
      },
    );
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
    );
  }

  @override
  Future<void> resetPassword(String newPassword) async {
    await _client.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );
  }

  @override
  Future<bool> profileExists() async {
    final currentUser = _client.auth.currentUser;

    if (currentUser == null) return false;

    final response = await _client
        .from('profiles')
        .select('id')
        .eq('id', currentUser.id)
        .maybeSingle();

    return response != null;
  }

  @override
  Future<void> createUserProfileFromMetadata() async {
    final currentUser = _client.auth.currentUser;

    if (currentUser == null) {
      throw Exception("User not logged in");
    }

    final metadata = currentUser.userMetadata ?? {};

    final exists = await _client
        .from('profiles')
        .select('id')
        .eq('id', currentUser.id)
        .maybeSingle();

    if (exists != null) return;

    await _client.from('profiles').insert({
      'id': currentUser.id,
      'email': currentUser.email,
      'username': metadata['username'],
      'name': metadata['name'],
      'phone': metadata['phone'],
      'address': metadata['address'],
    });
  }

  @override
  Future<UserModel?> getCurrentUserProfile() async {
    final currentUser = _client.auth.currentUser;

    if (currentUser == null) {
      return null;
    }

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', currentUser.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return UserModel.fromJson(response);
  }

  @override
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  @override
  Stream<AuthState> authStateChanges() {
    return _client.auth.onAuthStateChange;
  }
}