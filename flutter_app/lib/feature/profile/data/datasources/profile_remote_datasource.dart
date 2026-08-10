import 'package:Krishivani/feature/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDatasource {
  final SupabaseClient _supabase;

  ProfileRemoteDatasource(this._supabase);

  Future<ProfileModel> getProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return ProfileModel.fromMap(response);
  }

  Future<ProfileModel> updateProfile({
    required String userId,
    required String column,
    required dynamic value,
  }) async {
    final response = await _supabase
        .from('profiles')
        .update({
      column: value,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('id', userId)
        .select()
        .single();

    return ProfileModel.fromMap(response);
  }
}