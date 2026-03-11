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
}
