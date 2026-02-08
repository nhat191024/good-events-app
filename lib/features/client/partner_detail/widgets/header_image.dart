import 'package:cached_network_image/cached_network_image.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class PartnerHeaderImage extends StatelessWidget {
  final String imageUrl;

  const PartnerHeaderImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    logger.d('image url $imageUrl');
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: imageUrl.isEmpty
            ? const Center(child: Icon(Icons.image, size: 50, color: Colors.grey))
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
              ),
      ),
    );
  }
}
