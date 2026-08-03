import 'package:sukientotapp/data/models/common/call_model.dart';

abstract class CallRepository {
  Future<CallSession> create({
    required String threadId,
    required CallType type,
    required List<int> invitedUserIds,
  });
  Future<CallModel?> active(String threadId);
  Future<CallSession> join(String callId);
  Future<void> leave(String callId);
  Future<void> decline(String callId);
  Future<void> end(String callId);
}

class CallApiException implements Exception {
  const CallApiException({required this.message, this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
