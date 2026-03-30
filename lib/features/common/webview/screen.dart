import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewScreen extends StatefulWidget {
  final String url;
  final String? title;
  final bool allowReload;

  const CommonWebviewScreen({
    super.key,
    required this.url,
    this.title,
    this.allowReload = false,
  });

  @override
  State<CommonWebviewScreen> createState() => _CommonWebviewScreenState();
}

class _CommonWebviewScreenState extends State<CommonWebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Can update progress bar
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            logger.e('WebView Error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.tryParse(request.url);
            logger.i('WebView Navigation Request: $uri');

            if (request.url.startsWith('intent://')) {
              logger.w('Intent URL detected and blocked: ${request.url}');
              return NavigationDecision.prevent;
            }

            if (uri != null && uri.scheme == 'sukientot') {
              final basePath = uri.host.isNotEmpty
                  ? '/${uri.host}${uri.path}'
                  : uri.path;
              final fullPath = uri.query.isNotEmpty
                  ? '$basePath?${uri.query}'
                  : basePath;
              logger.i('Deep link detected, navigating to: $fullPath');
              Get.toNamed(fullPath);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(widget.title ?? 'video'.tr),
        prefixes: [FHeaderAction.back(onPress: () => Get.back())],
        suffixes: [
          if (widget.allowReload)
            FHeaderAction(
              icon: const Icon(Icons.refresh),
              onPress: () => _controller.reload(),
            ),
        ],
      ),
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
