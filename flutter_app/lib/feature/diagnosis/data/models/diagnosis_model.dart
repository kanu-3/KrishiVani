class DiagnosisModel {
  final String disease;
  final double confidence;

  const DiagnosisModel({
    required this.disease,
    required this.confidence,
  });

  factory DiagnosisModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return DiagnosisModel(
      disease: map['disease'] as String,
      confidence: (map['confidence'] as num).toDouble(),
    );
  }

  String get plantName {
    final parts = disease.split('___');

    return parts.first;
  }

  String get diseaseName {
    final parts = disease.split('___');

    if (parts.length > 1) {
      return parts.sublist(1).join('___');
    }

    return disease;
  }

  Map<String, dynamic> toMap() {
    return {
      'disease': disease,
      'confidence': confidence,
    };
  }
}