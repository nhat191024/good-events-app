part of '../profile_preview.dart';

class _ServicesCard extends StatelessWidget {
  final List<PublicProfileServiceModel> services;
  static const int _previewLimit = 3;

  const _ServicesCard({required this.services});

  @override
  Widget build(BuildContext context) {
    final List<PublicProfileServiceModel> previewServices = services
        .take(_previewLimit)
        .toList();
    final bool hasMore = services.length > _previewLimit;

    return _SectionCard(
      title: 'services'.tr,
      child: services.isEmpty
          ? _EmptyText(text: 'public_profile_no_services'.tr)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...previewServices.map(_buildServiceItem),
                if (hasMore) ...[
                  const SizedBox(height: 12),
                  _SeeMoreButton(
                    onPressed: () => _showServicesBottomSheet(context),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildServiceItem(PublicProfileServiceModel service) {
    return Builder(
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name.isNotEmpty ? service.name : 'service'.tr,
                    style: context.typography.sm.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  if (service.category?.name.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${'field'.tr}: ${service.category!.name}',
                      style: context.typography.xs.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void _showServicesBottomSheet(BuildContext context) {
    _showPreviewBottomSheet(
      context,
      title: 'services'.tr,
      child: Column(
        children: services.map(_buildServiceItem).toList(),
      ),
    );
  }
}
