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
    final redirectUri = dotenv.env['APPLE_REDIRECT_URI'] ?? '';

    if (redirectUri.isEmpty || redirectUri.startsWith('http')) {
      return redirectUri;
    }

    return '${apiBaseUrl.replaceAll(RegExp(r'/+$'), '')}/${redirectUri.replaceAll(RegExp(r'^/+'), '')}';
  }

  static bool get hasAppleSignInConfig {
    return appleServiceId.isNotEmpty && appleRedirectUri.isNotEmpty;
  }
}
