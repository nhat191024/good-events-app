import 'dart:io';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/message_model.dart'; // Correct import
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isFirst;

  const ChatBubble({super.key, required this.message, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    final isImageMessage = message.type == 'image';
    return Padding(
      padding: EdgeInsets.fromLTRB(12, isFirst ? 12 : 2, 12, 2),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!isSender)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 3),
              child: Text(
                message.sender,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isSender)
                Padding(
                  padding: const EdgeInsets.only(right: 6, bottom: 2),
                  child: Text(
                    message.time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isImageMessage ? 0 : 14,
                    vertical: isImageMessage ? 0 : 10,
                  ),
                  decoration: BoxDecoration(
                    color: isImageMessage
                        ? Colors.transparent
                        : isSender
                            ? AppColors.primary
                            : Colors.white,
                    borderRadius: isImageMessage
                        ? null
                        : BorderRadius.only(
                            topLeft: const Radius.circular(18),
                            topRight: const Radius.circular(18),
                            bottomLeft: Radius.circular(isSender ? 18 : 4),
                            bottomRight: Radius.circular(isSender ? 4 : 18),
                          ),
                    boxShadow: isImageMessage
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: isImageMessage
                      ? _BubbleContent(
                          message: message,
                          isSender: isSender,
                        )
                      : _BubbleContent(
                          message: message,
                          isSender: isSender,
                        ),
                ),
              ),
              if (!isSender)
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 2),
                  child: Text(
                    message.time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BubbleContent extends StatelessWidget {
  const _BubbleContent({required this.message, required this.isSender});

  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    if (message.type == 'image' && message.attachments.isNotEmpty) {
      return _ImageMessageContent(message: message, isSender: isSender);
    }

    if (message.type == 'location' && message.location != null) {
      return _LocationMessageContent(message: message, isSender: isSender);
    }

    return Text(
      message.text.isEmpty ? message.previewText : message.text,
      style: TextStyle(
        color: isSender ? Colors.white : const Color(0xFF1F2937),
        fontSize: 14,
        height: 1.45,
      ),
    );
  }
}

class _ImageMessageContent extends StatelessWidget {
  const _ImageMessageContent({required this.message, required this.isSender});

  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final attachments = message.attachments
        .where(
          (attachment) =>
              attachment.url.isNotEmpty || attachment.localPath.isNotEmpty,
        )
        .toList();
    if (attachments.isEmpty) {
      return Text(
        message.previewText,
        style: TextStyle(
          color: isSender ? Colors.white : const Color(0xFF1F2937),
          fontSize: 14,
          height: 1.45,
        ),
      );
    }

    final visibleAttachments = attachments.take(4).toList();
    final tileSize = attachments.length == 1 ? 190.0 : 92.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: visibleAttachments.map((attachment) {
            final isLastVisible =
                attachments.length > 4 && attachment == visibleAttachments.last;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  _MessageImageTile(
                    attachment: attachment,
                    size: tileSize,
                  ),
                  if (isLastVisible)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.45),
                        child: Center(
                          child: Text(
                            '+${attachments.length - 4}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
        if (message.text.isNotEmpty && message.text != message.previewText) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              message.text,
              style: TextStyle(
                color: isSender ? Colors.white : const Color(0xFF1F2937),
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MessageImageTile extends StatelessWidget {
  const _MessageImageTile({required this.attachment, required this.size});

  final MessageAttachmentModel attachment;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (attachment.localPath.isNotEmpty && attachment.url.isEmpty) {
      return Image.file(
        File(attachment.localPath),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _ImageErrorTile(size: size);
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: attachment.url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: const Color(0xFFE5E7EB),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => _ImageErrorTile(size: size),
    );
  }
}

class _ImageErrorTile extends StatelessWidget {
  const _ImageErrorTile({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: const Color(0xFFE5E7EB),
      child: const Icon(Icons.broken_image_outlined),
    );
  }
}

class _LocationMessageContent extends StatelessWidget {
  const _LocationMessageContent({
    required this.message,
    required this.isSender,
  });

  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final location = message.location!;
    final title = location.label?.isNotEmpty == true
        ? location.label!
        : 'Vị trí hiện tại';
    final subtitle = location.address?.isNotEmpty == true
        ? location.address!
        : '${location.latitude}, ${location.longitude}';

    return InkWell(
      onTap: () => _openMap(location),
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isSender
                  ? Colors.white.withValues(alpha: 0.18)
                  : AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: isSender ? Colors.white : AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSender ? Colors.white : const Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSender
                        ? Colors.white.withValues(alpha: 0.82)
                        : const Color(0xFF6B7280),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMap(MessageLocationModel location) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
