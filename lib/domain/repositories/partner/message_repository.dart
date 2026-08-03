import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/data/models/chat_invitation_model.dart';

abstract class MessageRepository {
  Future<Map<String, dynamic>> getThreads({
    required int page,
    String? side,
    String? search,
  });

  Future<Map<String, dynamic>> getMessages({
    required String threadId,
    required int page,
  });

  Future<void> sendMessage({
    required String threadId,
    required String type,
    String? body,
    List<XFile>? images,
    Map<String, dynamic>? location,
  });

  Future<List<ChatUserSearchResult>> searchUsersByPhone(String phone);

  Future<ChatInvitationResponse> inviteUser({
    required String threadId,
    required int userId,
  });

  Future<ChatInvitationResponse> acceptInvitation(String threadId);

  Future<String> leaveThread(String threadId);
}
