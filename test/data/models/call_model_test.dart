import 'package:flutter_test/flutter_test.dart';
import 'package:sukientotapp/data/models/common/call_model.dart';

void main() {
  group('CallModel', () {
    test('parses typed audio call and nullable fields', () {
      final model = CallModel.fromJson({
        'id': '01K1ABCDEF1234567890ABCDEF',
        'thread_id': 123,
        'type': 'audio',
        'status': 'ringing',
        'initiator': {'id': 7, 'name': 'Caller', 'avatar': null},
        'invited_users': [
          {'id': 12, 'name': 'Invitee', 'avatar': null, 'status': 'pending'},
        ],
        'participants': [
          {'id': 7, 'name': 'Caller', 'joined_at': '2026-08-02T16:30:00+07:00'},
        ],
        'started_at': '2026-08-02T16:30:00+07:00',
        'ended_at': null,
        'expires_at': '2026-08-02T20:30:00+07:00',
      });

      expect(model.id, '01K1ABCDEF1234567890ABCDEF');
      expect(model.threadId, 123);
      expect(model.type, CallType.audio);
      expect(model.status, CallStatus.ringing);
      expect(model.initiator?.avatar, isNull);
      expect(model.invitedUsers.single.status, CallInviteStatus.pending);
      expect(model.endedAt, isNull);
    });

    test('unknown enum values do not crash parsing', () {
      final model = CallModel.fromJson({
        'id': '01K',
        'thread_id': '123',
        'type': 'screen_share',
        'status': 'paused',
      });

      expect(model.threadId, 123);
      expect(model.type, CallType.unknown);
      expect(model.status, CallStatus.unknown);
    });
  });

  test('CallSession preserves backend Agora UID and credentials', () {
    final session = CallSession.fromJson({
      'call': {
        'id': '01K',
        'thread_id': 123,
        'type': 'audio',
        'status': 'active',
      },
      'credentials': {
        'app_id': 'app-id',
        'channel': 'call_01K',
        'uid': 7,
        'token': 'token',
        'expires_in': 3600,
        'expires_at': '2026-08-02T17:30:00+07:00',
      },
    });

    expect(session.credentials.uid, 7);
    expect(session.credentials.channel, 'call_01K');
  });
}
