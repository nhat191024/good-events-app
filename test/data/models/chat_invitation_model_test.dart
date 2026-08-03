import 'package:flutter_test/flutter_test.dart';
import 'package:sukientotapp/data/models/chat_invitation_model.dart';

void main() {
  group('Chat invitation models', () {
    test('parses a phone search result with an integer id', () {
      final user = ChatUserSearchResult.fromJson(<String, dynamic>{
        'id': 42,
        'name': 'Nguyen Van B',
        'phone': '0901234567',
      });

      expect(user.id, 42);
      expect(user.phone, '0901234567');
    });

    test('parses invitation status and nullable timestamps', () {
      final response = ChatInvitationResponse.fromJson(<String, dynamic>{
        'message': 'Bạn đã tham gia đoạn chat.',
        'invitation': <String, dynamic>{
          'id': 15,
          'thread_id': 120,
          'user_id': 42,
          'invited_by_user_id': 7,
          'status': 'accepted',
          'accepted_at': '2026-08-04T10:30:00+07:00',
          'left_at': null,
        },
      });

      expect(response.invitation.threadId, 120);
      expect(response.invitation.status, ChatInvitationStatus.accepted);
      expect(response.invitation.acceptedAt, isNotNull);
      expect(response.invitation.leftAt, isNull);
    });
  });
}
