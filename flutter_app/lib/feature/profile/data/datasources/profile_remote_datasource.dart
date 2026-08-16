import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';

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

  Future<ProfileModel> uploadProfilePicture({
    required String userId,
    required Uint8List imageBytes,
  }) async {
    print('========== STORAGE TEST START ==========');

    final session = _supabase.auth.currentSession;
    final currentUser = _supabase.auth.currentUser;

    print('USER ID: ${currentUser?.id}');
    print('SESSION EXISTS: ${session != null}');
    print(
      'ACCESS TOKEN EXISTS: ${session?.accessToken.isNotEmpty}',
    );
    print('EMAIL: ${currentUser?.email}');

    print('========== JWT DEBUG ==========');
    print('JWT ROLE: ${session?.user.role}');
    print('JWT USER ID: ${session?.user.id}');
    print(
      'ACCESS TOKEN EXISTS: '
          '${session?.accessToken.isNotEmpty}',
    );

    print('STEP 1: Getting buckets...');

    try {
      final buckets = await _supabase.storage.listBuckets();

      print('STEP 2: Buckets received');

      for (final bucket in buckets) {
        print(
          'BUCKET: ${bucket.id} | PUBLIC: ${bucket.public}',
        );
      }
    } catch (e, stackTrace) {
      print('========== LIST BUCKETS ERROR ==========');
      print('ERROR: $e');
      print('STACK: $stackTrace');

      rethrow;
    }

    print('STEP 3: Creating storage path...');

    final storagePath = '$userId/profile.jpg';

    print('STORAGE PATH: $storagePath');

    print('STEP 4: Uploading...');

    try {
      await _supabase.storage
          .from('profile_images')
          .uploadBinary(
        storagePath,
        imageBytes,
        fileOptions: const FileOptions(
          upsert: false,
          contentType: 'image/jpeg',
        ),
      );

      print('STEP 5: UPLOAD SUCCESS');
    } catch (e, stackTrace) {
      print('========== UPLOAD ERROR ==========');
      print('ERROR: $e');
      print('STACK: $stackTrace');

      rethrow;
    }

    print('STEP 6: Getting public URL...');

    final imageUrl = _supabase.storage
        .from('profile_images')
        .getPublicUrl(storagePath);

    print('IMAGE URL: $imageUrl');

    print('STEP 7: Updating profile...');

    final response = await _supabase
        .from('profiles')
        .update({
      'avatar_url': imageUrl,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('id', userId)
        .select()
        .single();

    print('STEP 8: PROFILE UPDATE SUCCESS');

    return ProfileModel.fromMap(response);
  }
}