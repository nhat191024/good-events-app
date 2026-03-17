import 'package:dio/dio.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/services/localstorage_service.dart';
import 'package:sukientotapp/core/utils/env_config.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class PusherService {
  PusherService._();

  static final PusherChannelsFlutter _pusher =
      PusherChannelsFlutter.getInstance();

  static bool _initialized = false;
  static String _connectionState = 'DISCONNECTED';
  static final Set<String> _channels = {};

  static String get connectionState => _connectionState;
  static Set<String> get channels => Set.unmodifiable(_channels);
  static bool get isInitialized => _initialized;
  static Future<String?> getSocketId() => _pusher.getSocketId();

  static Future<void> init() async {
    if (_initialized) return;

    try {
      await _pusher.init(
        apiKey: EnvConfig.pusherAppKey,
        cluster: EnvConfig.pusherCluster,
        onConnectionStateChange: (currentState, previousState) {
          _connectionState = currentState;
          logger.i('[Pusher] [Connection] $previousState -> $currentState');
        },
        onError: (message, code, error) {
          logger.e('[Pusher] [Error] $message (code: $code)');
        },
        onAuthorizer: (channelName, socketId, options) async {
          return await _authorizeChannel(channelName, socketId);
        },
      );

      await _pusher.connect();
      _initialized = true;
      logger.i('[Pusher] [Init] Connected successfully');
    } catch (e) {
      logger.e('[Pusher] [Init] Failed to initialize: $e');
      rethrow;
    }
  }

  static Future<dynamic> _authorizeChannel(
    String channelName,
    String socketId,
  ) async {
    final token = StorageService.readData(key: LocalStorageKeys.token);
    final authUrl = '${EnvConfig.apiBaseUrl}/broadcasting/auth';

    try {
      final dio = Dio();
      final response = await dio.post<Map<String, dynamic>>(
        authUrl,
        data: {'channel_name': channelName, 'socket_id': socketId},
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      logger.i('[Pusher] [Auth] Authorized channel: $channelName');
      return response.data;
    } on DioException catch (e) {
      logger.e(
        '[Pusher] [Auth] Failed (${e.response?.statusCode}): ${e.response?.data}',
      );
      return null;
    } catch (e) {
      logger.e('[Pusher] [Auth] Exception: $e');
      return null;
    }
  }

  static Future<void> subscribe({
    required String channelName,
    required String eventName,
    required void Function(PusherEvent) onEvent,
  }) async {
    await _pusher.subscribe(
      channelName: channelName,
      onEvent: (dynamic event) => onEvent(event as PusherEvent),
    );
    _channels.add(channelName);
    logger.i('[Pusher] [Subscribe] Channel: $channelName, Event: $eventName');
  }

  static Future<void> unsubscribe(String channelName) async {
    await _pusher.unsubscribe(channelName: channelName);
    _channels.remove(channelName);
    logger.i('[Pusher] [Unsubscribe] Channel: $channelName');
  }

  static Future<void> disconnect() async {
    await _pusher.disconnect();
    _channels.clear();
    _connectionState = 'DISCONNECTED';
    _initialized = false;
    logger.i('[Pusher] [Disconnect] Disconnected');
  }
}
