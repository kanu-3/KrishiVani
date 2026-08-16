import 'dart:io';
import 'dart:typed_data';

import 'package:Krishivani/feature/profile/data/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileState());

  Future<bool> uploadProfilePicture(Uint8List imageBytes) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      state = state.copyWith(
        error: 'User is not authenticated.',
      );
      return false;
    }

    state = state.copyWith(
      isUpdating: true,
      error: null,
    );

    try {
      final profile = await _repository.uploadProfilePicture(
        userId: user.id,
        imageBytes: imageBytes,
      );

      state = state.copyWith(
        profile: profile,
        isUpdating: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        error: e.toString(),
      );

      return false;
    }
  }

  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      state = state.copyWith(
        error: 'User is not authenticated.',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final profile = await _repository.getProfile(user.id);

      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> updateProfile({
    required String column,
    required dynamic value,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      state = state.copyWith(
        error: 'User is not authenticated.',
      );
      return false;
    }

    state = state.copyWith(
      isUpdating: true,
      error: null,
    );

    try {
      final profile = await _repository.updateProfile(
        userId: user.id,
        column: column,
        value: value,
      );

      state = state.copyWith(
        profile: profile,
        isUpdating: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        error: e.toString(),
      );

      return false;
    }
  }
}