import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

class CallProvider {
  const CallProvider(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> create({
    required String threadId,
    required String type,
    required List<int> invitedUserIds,
  }) => _post(
    AppUrl.createCall(threadId),
    data: {'type': type, 'invited_user_ids': invitedUserIds},
  );

  Future<Map<String, dynamic>> active(String threadId) =>
      _get(AppUrl.activeCall(threadId));

  Future<Map<String, dynamic>> join(String callId) =>
      _post(AppUrl.joinCall(callId));

  Future<Map<String, dynamic>> leave(String callId) =>
      _post(AppUrl.leaveCall(callId));

  Future<Map<String, dynamic>> decline(String callId) =>
      _post(AppUrl.declineCall(callId));

  Future<Map<String, dynamic>> end(String callId) =>
      _post(AppUrl.endCall(callId));

  Future<Map<String, dynamic>> _get(String path) async {
    final response = await _apiService.dio.get<Map<String, dynamic>>(path);
    return response.data ?? <String, dynamic>{};
  }

  Future<Map<String, dynamic>> _post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final response = await _apiService.dio.post<Map<String, dynamic>>(
      path,
      data: data,
      options: Options(extra: const {'sensitiveResponse': true}),
    );
    return response.data ?? <String, dynamic>{};
  }
}
