class DiagnosisHistoryModel {
  final String id;
  final String imageUrl;
  final String inputType;
  final String plantName;
  final String diseaseName;
  final double confidence;
  final DateTime createdAt;

  const DiagnosisHistoryModel({
    required this.id,
    required this.imageUrl,
    required this.inputType,
    required this.plantName,
    required this.diseaseName,
    required this.confidence,
    required this.createdAt,
  });

  factory DiagnosisHistoryModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return DiagnosisHistoryModel(
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
      inputType: map['input_type'] as String,
      plantName: map['plant_name'] as String,
      diseaseName: map['disease_name'] as String,
      confidence: (map['confidence'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }

  double get confidencePercentage => confidence * 100;
}