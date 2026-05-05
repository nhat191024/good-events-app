import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? '';
  }

  static String get pusherAppKey {
    return dotenv.env['PUSHER_APP_KEY'] ?? '';
  }

  static String get pusherCluster {
    return dotenv.env['PUSHER_CLUSTER'] ?? '';
  }

  static String get appleServiceId {
    return dotenv.env['APPLE_SERVICE_ID'] ?? '';
  }

  static String get appleRedirectUri {
    return dotenv.env['APPLE_REDIRECT_URI'] ?? '';
  }

  static bool get hasAppleSignInConfig {
    return appleServiceId.isNotEmpty && appleRedirectUri.isNotEmpty;
  }
}
