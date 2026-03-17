import 'dart:async';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../order_status_badge.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard({
    super.key,
    required this.order,
  });

  final HistoryOrderModel order;

  String _formatUpdatedAt() {
    if (order.updatedAt == null) return '';
    try {
      final dt = DateTime.parse(order.updatedAt!);
      final timeStr = DateFormat('HH:mm').format(dt);
      final dateStr = DateFormat('dd/MM/yyyy').format(dt);

      final isVietnamese = Get.locale?.languageCode == 'vi';
      final days = isVietnamese
          ? ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7']
          : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      final dayOfWeek = days[dt.weekday % 7];

      return '$timeStr • $dayOfWeek, $dateStr';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final partnerName =
        order.partner?.partnerProfile?.partnerName ?? order.partner?.name ?? 'partner_not_found'.tr;
    final rating = order.partner?.statistics?.averageStars;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.toNamed(Routes.clientOrderDetail, arguments: {'order': order, 'isHistory': true});
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: ClipOval(
                    child: _DynamicAvatar(
                      arrivalPhoto: order.arrivalPhoto,
                      categoryImage: order.categoryImage,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        '${order.categoryName ?? ''} ${order.parentCategoryName ?? ''}'.trim(),
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Time creation
                      Row(
                        children: [
                          Text(
                            'created_at_label'.tr,
                            style: context.typography.xs.copyWith(color: Colors.grey[500]),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatUpdatedAt(),
                            style: context.typography.xs.copyWith(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Partner Info
                      Row(
                        children: [
                          Text(
                            'partner_received'.tr,
                            style: context.typography.xs.copyWith(color: Colors.grey[500]),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              partnerName,
                              style: context.typography.xs.copyWith(fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Rating
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 12, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                rating != null ? rating.toStringAsFixed(1) : 'unrated'.tr,
                                style: context.typography.xs.copyWith(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Footer (Price & Status)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            order.finalTotal != null || order.total != null
                                ? NumberFormat.currency(
                                    locale: 'vi_VN',
                                    symbol: '₫',
                                  ).format(order.finalTotal ?? order.total)
                                : '0 ₫',
                            style: context.typography.sm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.primary,
                            ),
                          ),
                          OrderStatusBadge(
                            status: order.status,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DynamicAvatar extends StatefulWidget {
  final String? arrivalPhoto;
  final String? categoryImage;

  const _DynamicAvatar({this.arrivalPhoto, this.categoryImage});

  @override
  State<_DynamicAvatar> createState() => _DynamicAvatarState();
}

class _DynamicAvatarState extends State<_DynamicAvatar> {
  int _currentIndex = 0;
  Timer? _timer;
  final List<String> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.arrivalPhoto != null && widget.arrivalPhoto!.isNotEmpty) {
      _images.add(widget.arrivalPhoto!);
    }
    if (widget.categoryImage != null && widget.categoryImage!.isNotEmpty) {
      _images.add(widget.categoryImage!);
    }

    if (_images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _images.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return Icon(Icons.person, color: Colors.grey[400]);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: CachedNetworkImage(
        key: ValueKey<String>(_images[_currentIndex]),
        imageUrl: _images[_currentIndex],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (context, url, error) =>
            Icon(Icons.image_not_supported, color: Colors.grey[400]),
      ),
    );
  }
}
