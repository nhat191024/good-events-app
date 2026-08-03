import 'package:dio/dio.dart';
import 'package:sukientotapp/data/models/common/call_model.dart';
import 'package:sukientotapp/data/providers/common/call_provider.dart';
import 'package:sukientotapp/domain/repositories/common/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  const CallRepositoryImpl(this._provider);
  final CallProvider _provider;

  @override
  Future<CallSession> create({
    required String threadId,
    required CallType type,
    required List<int> invitedUserIds,
  }) => _guard(() async => CallSession.fromJson(await _provider.create(
    threadId: threadId,
    type: type.name,
    invitedUserIds: invitedUserIds.toSet().toList(growable: false),
  )));

  @override
  Future<CallModel?> active(String threadId) => _guard(() async {
    final data = await _provider.active(threadId);
    final call = data['call'];
    return call is Map<String, dynamic> ? CallModel.fromJson(call) : null;
  });

  @override
  Future<CallSession> join(String callId) =>
      _guard(() async => CallSession.fromJson(await _provider.join(callId)));

  @override
  Future<void> leave(String callId) => _guard(() async {
    await _provider.leave(callId);
  });

  @override
  Future<void> decline(String callId) => _guard(() async {
    await _provider.decline(callId);
  });

  @override
  Future<void> end(String callId) => _guard(() async {
    await _provider.end(callId);
  });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      final data = error.response?.data;
      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : null;
      throw CallApiException(
        message: message ?? 'Không thể kết nối đến máy chủ cuộc gọi.',
        statusCode: error.response?.statusCode,
      );
    } on FormatException catch (error) {
      throw CallApiException(message: error.message);
    }
  }
}
