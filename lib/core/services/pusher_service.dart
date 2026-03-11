import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/env_config.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class PusherService {
  PusherService._();

  static final PusherChannelsFlutter _pusher =
      PusherChannelsFlutter.getInstance();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    try {
      await _pusher.init(
        apiKey: EnvConfig.pusherAppKey,
        cluster: EnvConfig.pusherCluster,
        onConnectionStateChange: (currentState, previousState) {
          logger.i('[Pusher] [Connection] $previousState -> $currentState');
        },
        onError: (message, code, error) {
          logger.e('[Pusher] [Error] $message (code: $code)');
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

  static Future<void> subscribe({
    required String channelName,
    required String eventName,
    required void Function(PusherEvent) onEvent,
  }) async {
    await _pusher.subscribe(
      channelName: channelName,
      onEvent: onEvent,
    );
    logger.i('[Pusher] [Subscribe] Channel: $channelName, Event: $eventName');
  }

  static Future<void> unsubscribe(String channelName) async {
    await _pusher.unsubscribe(channelName: channelName);
    logger.i('[Pusher] [Unsubscribe] Channel: $channelName');
  }

  static Future<void> disconnect() async {
    await _pusher.disconnect();
    _initialized = false;
    logger.i('[Pusher] [Disconnect] Disconnected');
  }
}
