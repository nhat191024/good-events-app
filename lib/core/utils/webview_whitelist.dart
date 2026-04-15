import 'package:sukientotapp/core/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWhitelist {
  static const List<String> defaultAllowedHosts = [
    'sukientot.com',
    'www.sukientot.com',
    'api.sukientot.com',
    'youtube.com',
    'www.youtube.com',
    'youtu.be',
    'm.youtube.com',
  ];

  static const List<String> _allowedInternalSchemes = [
    'about',
    'data',
    'javascript',
  ];

  static bool isIntentUrl(String url) => url.startsWith('intent://');

  static bool isDeepLink(Uri uri) => uri.scheme == 'sukientot';

  static bool isAllowed(
    String url, {
    List<String> extraAllowedHosts = const [],
  }) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    if (isDeepLink(uri) || _allowedInternalSchemes.contains(uri.scheme)) {
      return true;
    }

    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return false;
    }

    final allowedHosts = <String>{
      ...defaultAllowedHosts,
      ...extraAllowedHosts,
    };

    return allowedHosts.any(
      (host) => uri.host == host || uri.host.endsWith('.$host'),
    );
  }

  static Future<NavigationDecision> decide(
    String url, {
    List<String> extraAllowedHosts = const [],
    bool openExternalBrowser = false,
  }) async {
    if (isAllowed(url, extraAllowedHosts: extraAllowedHosts)) {
      return NavigationDecision.navigate;
    }

    logger.w('[WebView] Blocked navigation to: $url');

    if (openExternalBrowser) {
      final uri = Uri.tryParse(url);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }

    return NavigationDecision.prevent;
  }
}
