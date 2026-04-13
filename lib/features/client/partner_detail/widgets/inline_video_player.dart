import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/core/utils/webview_whitelist.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InlineVideoPlayer extends StatefulWidget {
  final String htmlContent;
  final String thumbnailUrl;
  final VoidCallback onTapExternal;

  const InlineVideoPlayer({
    super.key,
    required this.htmlContent,
    required this.thumbnailUrl,
    required this.onTapExternal,
  });

  @override
  State<InlineVideoPlayer> createState() => _InlineVideoPlayerState();
}

class _InlineVideoPlayerState extends State<InlineVideoPlayer> {
  static const _inlineBaseUrl = 'https://sukientot.com';
  bool _isPlaying = false;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Defer initialization until the user taps play
  }

  void _initController() {
    if (widget.htmlContent.isNotEmpty) {
      // Ensure the iframe fits perfectly without margins
      final wrappedHtml =
          '''
        <!DOCTYPE html>
        <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            body, html { margin: 0; padding: 0; height: 100%; width: 100%; overflow: hidden; background-color: #000; }
            iframe { width: 100%; height: 100%; border: none; }
          </style>
        </head>
        <body>
          ${widget.htmlContent}
        </body>
        </html>
      ''';

      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.366',
        )
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.isMainFrame) {
                if (request.url == _inlineBaseUrl ||
                    request.url == '$_inlineBaseUrl/') {
                  return NavigationDecision.navigate;
                }

                if (WebviewWhitelist.isAllowed(request.url)) {
                  // Keep inline player pinned. Open allowed outbound video pages
                  // in dedicated screen instead of navigating inside iframe shell.
                  widget.onTapExternal();
                } else {
                  logger.w(
                    '[InlineVideoPlayer] Blocked navigation to: ${request.url}',
                  );
                }

                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadHtmlString(
          wrappedHtml,
          baseUrl: _inlineBaseUrl,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.htmlContent.isEmpty) {
      return const SizedBox.shrink();
    }

    if (_isPlaying) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: WebViewWidget(controller: _controller),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: GestureDetector(
                onTap: () => _controller.reload(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isPlaying = true;
          _initController();
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          image: widget.thumbnailUrl.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(widget.thumbnailUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.2),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: const Center(
          child: Icon(
            Icons.play_circle_fill,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
