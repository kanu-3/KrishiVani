class ChatRoomModel {
  final String id;
  final String userId;
  final String? diagnosisId;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChatRoomModel({
    required this.id,
    required this.userId,
    this.diagnosisId,
    this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatRoomModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return ChatRoomModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      diagnosisId: map['diagnosis_id'] as String?,
      title: map['title'] as String?,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        map['updated_at'] as String,
      ),
    );
  }

  ChatRoomModel copyWith({
    String? title,
  }) {
    return ChatRoomModel(
      id: id,
      userId: userId,
      diagnosisId: diagnosisId,
      title: title ?? this.title,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}