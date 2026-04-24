import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/order_detail_model.dart';
import '../controller/controller.dart';

class ApplicantCard extends GetView<ClientOrderDetailController> {
  final OrderItemModel item;

  const ApplicantCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final partner = item.partner;
    if (partner == null) return const SizedBox.shrink();

    final partnerName = partner.name;
    final avatarUrl = partner.avatar.isNotEmpty
        ? partner.avatar
        : 'https://ui-avatars.com/api/?name=$partnerName&background=random&size=512&format=png';
    final isChosen = item.status == 'closed';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isChosen
              ? Colors.green.withValues(alpha: 0.5)
              : FTheme.of(context).colors.primary.withValues(alpha: 0.2),
          width: isChosen ? 2 : 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  border: Border.all(
                    color: FTheme.of(
                      context,
                    ).colors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
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
                            partnerName,
                            style: context.typography.lg.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isChosen)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
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
                    const SizedBox(height: 8),
                    Text(
                      'proposed_partner_price'.tr,
                      style: context.typography.xs.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(item.total)} đ',
                      style: context.typography.base.copyWith(
                        fontWeight: FontWeight.bold,
                        color: FTheme.of(context).colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(() {
            final isEnded =
                controller.status == 'completed' ||
                controller.status == 'cancelled' ||
                controller.status == 'expired';

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    final partnerId = item.partner?.id;
                    if (partnerId != null) {
                      controller.openPartnerProfilePreview(partnerId);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: FTheme.of(context).colors.primary,
                    side: BorderSide(color: FTheme.of(context).colors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('profile'.tr),
                ),
                if (!controller.isHistory.value && !isEnded && !isChosen) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => controller.choosePartner(
                      partnerId: partner.id,
                      amount: item.total,
                      partnerName: partnerName,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FTheme.of(context).colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('choose_partner'.tr),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
