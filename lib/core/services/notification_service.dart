import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/services/localstorage_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

/// Background message handler — must be a top-level function.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('[FCM] Background message received: ${message.messageId}');
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final ApiService _apiService = ApiService();

  static Future<void> init() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    logger.i('[FCM] Permission status: ${settings.authorizationStatus}');

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final isGranted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!isGranted) {
      logger.w('[FCM] Notification permission not granted.');
      return;
    }

    await _fetchAndSaveToken();

    // 4. Refresh token listener
    _messaging.onTokenRefresh.listen((newToken) {
      StorageService.writeStringData(
        key: LocalStorageKeys.fcmToken,
        value: newToken,
      );
      logger.i('[FCM] Token refreshed: $newToken');
      _syncTokenToBackend(newToken);
    });

    // 5. Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title;
      final body = message.notification?.body;
      logger.i('[FCM] Foreground message — title: $title | body: $body');
      // TODO: display in-app notification (e.g. flutter_local_notifications)
    });

    // 6. App opened from a background notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('[FCM] Opened from background: ${message.notification?.title}');
      // TODO: navigate to relevant screen based on message.data
    });

    // 7. App launched from a terminated-state notification tap
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      logger.i(
        '[FCM] App launched from terminated state: ${initialMessage.notification?.title}',
      );
      // TODO: navigate to relevant screen based on initialMessage.data
    }
  }

  static Future<void> _fetchAndSaveToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        StorageService.writeStringData(
          key: LocalStorageKeys.fcmToken,
          value: token,
        );
        logger.i('[FCM] Registration token: $token');
        await _syncTokenToBackend(token);
      }
    } catch (e) {
      logger.e('[FCM] Failed to retrieve token', error: e);
    }
  }

  static Future<void> _syncTokenToBackend(String token) async {
    // Only sync when the user is authenticated
    final authToken = StorageService.readData(key: LocalStorageKeys.token);
    if (authToken == null) {
      logger.i('[FCM] Skipping backend sync — user not authenticated.');
      return;
    }

    try {
      final response = await _apiService.dio.post(
        AppUrl.updateFcmToken,
        data: {'fcm_token': token},
      );
      if (response.statusCode == 200) {
        logger.i('[FCM] Token synced to backend successfully.');
      }
    } on DioException catch (e) {
      logger.e('[FCM] Failed to sync token to backend', error: e.message);
    } catch (e) {
      logger.e('[FCM] Failed to sync token to backend', error: e);
    }
  }

  /// Returns the persisted FCM token (may be null before init completes).
  static String? getToken() {
    return StorageService.readData(key: LocalStorageKeys.fcmToken) as String?;
  }
}
