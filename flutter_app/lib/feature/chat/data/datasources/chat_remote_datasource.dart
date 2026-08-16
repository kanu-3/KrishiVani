import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRemoteDatasource {
  final SupabaseClient supabase;

  ChatRemoteDatasource({
    required this.supabase,
  });

  Future<List<ChatRoomModel>> getChatRooms() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not authenticated.',
      );
    }

    final response = await supabase
        .from('chat_rooms')
        .select()
        .eq('user_id', user.id)
        .order(
      'updated_at',
      ascending: false,
    );

    return (response as List)
        .map(
          (item) => ChatRoomModel.fromMap(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<ChatRoomModel?> getRoomByDiagnosisId(
      String diagnosisId,
      ) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not authenticated.',
      );
    }

    final response = await supabase
        .from('chat_rooms')
        .select()
        .eq('user_id', user.id)
        .eq('diagnosis_id', diagnosisId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return ChatRoomModel.fromMap(
      response,
    );
  }

  Future<ChatRoomModel> createChatRoom({
    String? diagnosisId,
    String? title,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not authenticated.',
      );
    }

    print('CHAT: creating room');
    print('CHAT: diagnosisId = $diagnosisId');
    print('CHAT: title = $title');

    final response = await supabase
        .from('chat_rooms')
        .insert({
      'user_id': user.id,
      'diagnosis_id': diagnosisId,
      'title': title,
    })
        .select()
        .single();

    print('CHAT: room created = $response');

    return ChatRoomModel.fromMap(
      response,
    );
  }

  Future<List<ChatMessageModel>> getMessages(
      String chatRoomId,
      ) async {
    final response = await supabase
        .from('chat_messages')
        .select()
        .eq(
      'chat_room_id',
      chatRoomId,
    )
        .order(
      'created_at',
      ascending: true,
    );

    return (response as List)
        .map(
          (item) => ChatMessageModel.fromMap(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<ChatMessageModel> addMessage({
    required String chatRoomId,
    required String role,
    required String message,
  }) async {
    final user = supabase.auth.currentUser;

    print(
      'CHAT AUTH USER = ${user?.id}',
    );

    print(
      'CHAT SESSION = '
          '${supabase.auth.currentSession != null}',
    );

    print('CHAT: inserting message');
    print('CHAT: roomId = $chatRoomId');
    print('CHAT: role = $role');
    print('CHAT: message = $message');

    try {
      final response = await supabase
          .from('chat_messages')
          .insert({
        'chat_room_id': chatRoomId,
        'role': role,
        'message': message,
      })
          .select()
          .single();

      print(
        'CHAT: message inserted = $response',
      );

      try {
        await supabase
            .from('chat_rooms')
            .update({
          'updated_at': DateTime.now()
              .toUtc()
              .toIso8601String(),
        })
            .eq(
          'id',
          chatRoomId,
        );

        print('CHAT: room updated');
      } catch (e, stackTrace) {
        print(
          'CHAT: room update failed = $e',
        );

        print(
          'CHAT: room update stack = $stackTrace',
        );
      }

      return ChatMessageModel.fromMap(
        response,
      );
    } catch (e, stackTrace) {
      print(
        'CHAT: INSERT ERROR = $e',
      );

      print(
        'CHAT: INSERT STACK TRACE = $stackTrace',
      );

      rethrow;
    }
  }

  Future<ChatRoomModel> getRoomById(
      String roomId,
      ) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not authenticated.',
      );
    }

    final response = await supabase
        .from('chat_rooms')
        .select()
        .eq('id', roomId)
        .eq('user_id', user.id)
        .single();

    return ChatRoomModel.fromMap(
      response,
    );
  }

  Future<Map<String, dynamic>?> getDiagnosisContext(
      String diagnosisId,
      ) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not authenticated.',
      );
    }

    final response = await supabase
        .from('diagnoses')
        .select(
      'plant_name, disease_name, confidence',
    )
        .eq('id', diagnosisId)
        .eq('user_id', user.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return {
      'crop': response['plant_name'],
      'disease': response['disease_name'],
      'confidence': (response['confidence'] as num)
          .toDouble(),
    };
  }
}