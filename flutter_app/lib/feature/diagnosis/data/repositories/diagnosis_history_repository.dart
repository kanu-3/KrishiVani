import 'package:Krishivani/feature/diagnosis/data/datasource/diagnosis_history_remote_datasource.dart';
import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_history_model.dart';

class DiagnosisHistoryRepository {
  final DiagnosisHistoryRemoteDatasource datasource;

  DiagnosisHistoryRepository(this.datasource);

  Future<List<DiagnosisHistoryModel>> getHistory() {
    return datasource.getHistory();
  }
}