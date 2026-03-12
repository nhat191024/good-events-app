import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller.dart';

class ApplicantListSection extends GetView<ClientOrderDetailController> {
  const ApplicantListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // We only show this list on Current Orders (not history) and if we have fetched items.
      if (controller.isHistory.value) return const SizedBox.shrink();

      final details = controller.orderDetail.value;
      if (controller.isLoadingDetails.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (details == null || details.items.isEmpty) {
        // Only return something if we're not closed/confirmed maybe,
        // but let's assume if it's empty we just don't have applicants.
        return const SizedBox.shrink();
      }

      return Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'applicants_list'.tr} (${details.items.length})',
              style: context.typography.xl.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...details.items.map((item) {
              final partner = item.partner;
              if (partner == null) return const SizedBox.shrink();

              // We consider an applicant chosen if its status is 'closed' in the details array,
              // or match the overall status 'confirmed' but 'closed' directly on item handles the specifics.
              final isChosen = item.status == 'closed';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isChosen
                        ? Colors.green.withValues(alpha: 0.5)
                        : FTheme.of(context).colors.primary.withValues(alpha: 0.2),
                    width: isChosen ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: partner.avatar.isNotEmpty
                              ? partner.avatar
                              : 'https://ui-avatars.com/api/?name=${partner.name}&background=random',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  partner.partnerProfile?.partnerName ?? partner.name,
                                  style: context.typography.base.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isChosen)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'chosen'.tr,
                                    style: context.typography.xs.copyWith(
                                      color: Colors.green[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${'proposed_partner_price'.tr}: ${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(item.total)} đ',
                            style: context.typography.sm.copyWith(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
