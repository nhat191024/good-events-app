import 'package:flutter_test/flutter_test.dart';
import 'package:sukientotapp/data/models/common/notification_model.dart';

void main() {
  test('parses an in-app chat invitation notification', () {
    final notification = NotificationModel.fromJson(<String, dynamic>{
      'id': 'notification-1',
      'type': 'chat_invitation',
      'thread_id': 120,
      'invitation_id': 15,
      'inviter': <String, dynamic>{'id': 7, 'name': 'Nguyen Van A'},
      'payload': <String, dynamic>{'source': 'original'},
      'unread': true,
      'created_at': '2026-08-04T10:30:00+07:00',
    });

    expect(notification.isChatInvitation, isTrue);
    expect(notification.threadId, 120);
    expect(notification.invitationId, 15);
    expect(notification.inviterId, 7);
    expect(notification.inviterName, 'Nguyen Van A');
    expect(notification.title, 'Lời mời tham gia đoạn chat');
    expect(notification.message, contains('Nguyen Van A'));
    expect(notification.payload['source'], 'original');
  });

  test('falls back to invitation fields inside payload', () {
    final notification = NotificationModel.fromJson(<String, dynamic>{
      'id': 'notification-2',
      'payload': <String, dynamic>{
        'type': 'chat_invitation',
        'thread_id': '121',
        'invitation_id': '16',
        'inviter': <String, dynamic>{'id': '8', 'name': 'User B'},
      },
    });

    expect(notification.isChatInvitation, isTrue);
    expect(notification.threadId, 121);
    expect(notification.invitationId, 16);
    expect(notification.inviterId, 8);
  });

  test('parses backend-normalized invitation fields inside data', () {
    final notification = NotificationModel.fromJson(<String, dynamic>{
      'id': 'notification-3',
      'title': '',
      'message': '',
      'unread': true,
      'data': <String, dynamic>{
        'type': 'chat_invitation',
        'thread_id': 120,
        'invitation_id': 15,
        'inviter': <String, dynamic>{'id': 7, 'name': 'Nguyen Van A'},
        'payload': <String, dynamic>{'original_key': 'original_value'},
      },
    });

    expect(notification.isChatInvitation, isTrue);
    expect(notification.threadId, 120);
    expect(notification.invitationId, 15);
    expect(notification.inviterName, 'Nguyen Van A');
    expect(notification.title, 'Lời mời tham gia đoạn chat');
    expect(notification.message, contains('Nguyen Van A'));
    expect(notification.data['type'], 'chat_invitation');
    expect(notification.payload['original_key'], 'original_value');
  });
}
