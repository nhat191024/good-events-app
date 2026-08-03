import 'package:flutter_test/flutter_test.dart';
import 'package:sukientotapp/data/models/message_model.dart';

void main() {
  group('CallMessageSummary', () {
    test('formats backend duration without recalculating timestamps', () {
      expect(CallMessageSummary.formatDuration(0), '0 giây');
      expect(CallMessageSummary.formatDuration(65), '1 phút 5 giây');
      expect(CallMessageSummary.formatDuration(3723), '1 giờ 2 phút 3 giây');
    });

    test('parses call message from realtime payload', () {
      final message = MessageModel.fromApiJson({
        'sender_id': 7,
        'message': {
          'id': 987,
          'thread_id': 123,
          'user_id': 7,
          'type': 'call',
          'body': null,
          'call': {
            'id': '01K1ABCDEF1234567890ABCDEF',
            'duration_seconds': 65,
            'started_at': '2026-08-03T20:00:00+07:00',
            'ended_at': '2026-08-03T20:01:05+07:00',
          },
          'preview_text': '[Cuộc gọi]',
          'created_at': '2026-08-03T20:01:05+07:00',
        },
        'user': {'id': 7, 'name': 'Nguyen Van A'},
      }, currentUserId: 7);

      expect(message.type, 'call');
      expect(message.userId, 7);
      expect(message.isSender, isTrue);
      expect(message.text, isEmpty);
      expect(message.previewText, '[Cuộc gọi]');
      expect(message.call?.id, '01K1ABCDEF1234567890ABCDEF');
      expect(message.call?.formattedDuration, '1 phút 5 giây');
    });

    test('allows legacy call messages with null summary', () {
      final message = MessageModel.fromApiJson({
        'message': {
          'id': 1,
          'thread_id': 123,
          'user_id': 8,
          'type': 'call',
          'call': null,
          'created_at': '2026-08-03T20:01:05+07:00',
        },
      }, currentUserId: 7);

      expect(message.call, isNull);
      expect(message.previewText, '[Cuộc gọi]');
    });
  });
}
