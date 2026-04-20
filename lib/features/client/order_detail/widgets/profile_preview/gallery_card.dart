part of '../profile_preview.dart';

class _GalleryCard extends StatelessWidget {
  final List<PublicProfileServiceModel> services;
  static const int _previewLimit = 3;
  static const int _previewImageLimit = 3;

  const _GalleryCard({required this.services});

  @override
  Widget build(BuildContext context) {
    final List<PublicProfileServiceModel> withImages = services
        .where((service) => service.images.isNotEmpty)
        .toList();
    final List<PublicProfileServiceModel> previewServices = withImages
        .take(_previewLimit)
        .toList();
    final bool hasMore = withImages.length > _previewLimit;

    return _SectionCard(
      title: 'service_images'.tr,
      child: withImages.isEmpty
          ? _EmptyText(text: 'public_profile_no_images'.tr)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...previewServices.map(
                  (service) => _buildGalleryService(
                    service,
                    limitImages: _previewImageLimit,
                  ),
                ),
                if (hasMore) ...[
                  const SizedBox(height: 12),
                  _SeeMoreButton(
                    onPressed: () => _showGalleryBottomSheet(context, withImages),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildGalleryService(
    PublicProfileServiceModel service, {
    int? limitImages,
  }) {
    final List<String> images = limitImages == null
        ? service.images
        : service.images.take(limitImages).toList();

    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    service.name.isNotEmpty ? service.name : 'service'.tr,
                    style: context.typography.sm.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (service.category?.name.isNotEmpty == true)
                  Text(
                    service.category!.name,
                    style: context.typography.xs.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFFF3F4F6),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showGalleryBottomSheet(
    BuildContext context,
    List<PublicProfileServiceModel> withImages,
  ) {
    _showPreviewBottomSheet(
      context,
      title: 'service_images'.tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: withImages.map((service) => _buildGalleryService(service)).toList(),
      ),
    );
  }
}
