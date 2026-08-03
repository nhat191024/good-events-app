import 'package:flutter/services.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class CallRingtoneService {
  CallRingtoneService._();

  static const MethodChannel _channel = MethodChannel(
    'com.sukientot.app/call_audio',
  );

  static Future<void> playIncoming() => _invoke('playIncoming');

  static Future<void> playOutgoing() => _invoke('playOutgoing');

  static Future<void> stop() => _invoke('stop');

  static Future<void> _invoke(String method) async {
    try {
      await _channel.invokeMethod<void>(method);
    } on MissingPluginException {
      logger.w('[CallRingtone] Native call audio is unavailable on this platform.');
    } on PlatformException catch (error) {
      logger.w('[CallRingtone] $method failed: ${error.code}');
    }
  }
}
