import '../datasources/chat_api_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRepository {
  final ChatRemoteDatasource datasource;
  final ChatApiDatasource apiDatasource;

  ChatRepository(
      this.datasource,
      this.apiDatasource,
      );

  Future<List<ChatRoomModel>> getChatRooms() {
    return datasource.getChatRooms();
  }

  Future<ChatRoomModel> createChatRoom({
    String? diagnosisId,
    String? title,
  }) {
    return datasource.createChatRoom(
      diagnosisId: diagnosisId,
      title: title,
    );
  }

  Future<List<ChatMessageModel>> getMessages(
      String chatRoomId,
      ) {
    return datasource.getMessages(chatRoomId);
  }

  Future<ChatMessageModel> addMessage({
    required String chatRoomId,
    required String role,
    required String message,
  }) {
    return datasource.addMessage(
      chatRoomId: chatRoomId,
      role: role,
      message: message,
    );
  }

  Future<ChatRoomModel> getRoomById(
      String roomId,
      ) {
    return datasource.getRoomById(
      roomId,
    );
  }

  Future<Map<String, dynamic>?> getDiagnosisContext(
      String diagnosisId,
      ) {
    return datasource.getDiagnosisContext(
      diagnosisId,
    );
  }

  Future<String> sendChatMessage({
    required String message,
    Map<String, dynamic>? diagnosis,
  }) {
    return apiDatasource.sendMessage(
      message: message,
      diagnosis: diagnosis,
    );
  }
}