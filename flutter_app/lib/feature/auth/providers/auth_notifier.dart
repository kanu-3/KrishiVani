import 'package:Krishivani/feature/auth/data/models/user_model.dart';
import 'package:Krishivani/feature/auth/data/repositories/auth_repository.dart';
import 'package:Krishivani/feature/auth/providers/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial());

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String name,
    String? phone,
    String? address,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
      );

      final user = UserModel(
        id: '',
        username: username,
        name: name,
        email: email,
        phone: phone,
        address: address,
        avatarUrl: null,
      );

      await _repository.signUp(
        email: email,
        password: password,
        user: user,
      );

      state = state.copyWith(
        isLoading: false,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _friendlyError(e.message),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Something went wrong. Please try again.",
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
      );

      await _repository.login(
        email: email,
        password: password,
      );

      final exists =
      await _repository.profileExists();

      if (!exists) {
        await _repository
            .createUserProfileFromMetadata();
      }

      final profile =
      await _repository.getCurrentUserProfile();

      state = state.copyWith(
        isLoading: false,
        user: profile,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _friendlyError(e.message),
      );
    } catch (e, st) {
      debugPrint("LOGIN ERROR: $e");
      debugPrintStack(stackTrace: st);

      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }}

  Future<void> logout() async {
    await _repository.logout();

    state = AuthState.initial();
  }

  Future<void> forgotPassword(
      String email) async {
    try {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
      );

      await _repository.forgotPassword(
        email,
      );

      state = state.copyWith(
        isLoading: false,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
        _friendlyError(e.message),
      );
    }
  }

  Future<void> resetPassword(
      String newPassword) async {
    try {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
      );

      await _repository.resetPassword(
        newPassword,
      );

      state = state.copyWith(
        isLoading: false,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
        _friendlyError(e.message),
      );
    }
  }

  Future<void> loadCurrentUser() async {
    final profile =
    await _repository.getCurrentUserProfile();

    state = state.copyWith(
      user: profile,
    );
  }

  User? get currentAuthUser =>
      _repository.getCurrentUser();

  String _friendlyError(String message) {
    final msg = message.toLowerCase();

    if (msg.contains("already registered")) {
      return "An account with this email already exists.";
    }

    if (msg.contains(
        "invalid login credentials")) {
      return "Incorrect email or password.";
    }

    if (msg.contains(
        "email not confirmed")) {
      return "Please verify your email before logging in.";
    }

    if (msg.contains("network")) {
      return "Please check your internet connection.";
    }

    return message;
  }
}