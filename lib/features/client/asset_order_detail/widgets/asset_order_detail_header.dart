import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller.dart';

class AssetOrderDetailHeader extends GetView<ClientAssetOrderDetailController> {
  const AssetOrderDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: FTheme.of(context).colors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: controller.thumbnail != null
                ? CachedNetworkImage(
                    imageUrl: controller.thumbnail!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => _placeholder(),
                  )
                : _placeholder(),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.productName,
                  style: context.typography.base.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  '${'category_label'.tr}: ${controller.categoryName}',
                  style: context.typography.sm.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: controller.statusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: controller.statusColor().withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    controller.statusLabel,
                    style: context.typography.xs.copyWith(
                      color: controller.statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[100],
      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey[400]),
    );
  }
}
