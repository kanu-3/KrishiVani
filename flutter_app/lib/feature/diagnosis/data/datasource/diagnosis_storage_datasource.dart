import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosisStorageDatasource {
  final SupabaseClient supabase;

  DiagnosisStorageDatasource({
    required this.supabase,
  });

  static const String bucketName = 'diagnosis_images';

  Future<String> uploadImage({
    required String diagnosisId,
    required Uint8List imageBytes,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final filePath = '${user.id}/$diagnosisId.jpg';

    await supabase.storage
        .from(bucketName)
        .uploadBinary(
      filePath,
      imageBytes,
      fileOptions: const FileOptions(
        contentType: 'image/jpeg',
        upsert: false,
      ),
    );

    return supabase.storage
        .from(bucketName)
        .getPublicUrl(filePath);
  }

  Future<void> deleteImage({
    required String diagnosisId,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return;
    }

    final filePath = '${user.id}/$diagnosisId.jpg';

    await supabase.storage
        .from(bucketName)
        .remove([filePath]);
  }
}