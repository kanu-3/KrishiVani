import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_history_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosisHistoryRemoteDatasource {
  final SupabaseClient supabase;

  DiagnosisHistoryRemoteDatasource({
    required this.supabase,
  });

  Future<List<DiagnosisHistoryModel>> getHistory() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final response = await supabase
        .from('diagnoses')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map(
          (item) => DiagnosisHistoryModel.fromMap(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}