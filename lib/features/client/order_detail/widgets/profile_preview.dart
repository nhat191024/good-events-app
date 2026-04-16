import 'package:flutter_html/flutter_html.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/public_profile_preview_model.dart';

class ProfilePreviewModal extends StatelessWidget {
  final PublicProfilePreviewModel? profile;
  final bool isLoading;
  final String errorMessage;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  const ProfilePreviewModal({
    super.key,
    required this.profile,
    required this.isLoading,
    required this.errorMessage,
    required this.onClose,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.sizeOf(context).width < 768;
    final double maxWidth = isMobile ? MediaQuery.sizeOf(context).width : 960;
    final double maxHeight =
        MediaQuery.sizeOf(context).height * (isMobile ? 0.92 : 0.85);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          minWidth: isMobile ? 0 : 720,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.white,
            child: _buildBody(context, isMobile),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isMobile) {
    if (isLoading) {
      return SizedBox(
        height: 320,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: FTheme.of(context).colors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'loading_profile_preview'.tr,
                style: context.typography.sm.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage.isNotEmpty || profile == null) {
      return SizedBox(
        height: 320,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
                const SizedBox(height: 12),
                Text(
                  errorMessage.isNotEmpty
                      ? errorMessage
                      : 'failed_to_load_public_profile'.tr,
                  textAlign: TextAlign.center,
                  style: context.typography.sm.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: onRetry,
                  style: FilledButton.styleFrom(
                    backgroundColor: FTheme.of(context).colors.primary,
                  ),
                  child: Text('retry'.tr),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final payload = profile!.payload;

    return Column(
      children: [
        _Header(
          user: payload.user,
          onClose: onClose,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ActionCard(
                  onReportPressed: () {
                    // TODO(dev): wire real report-user flow when backend/API is ready.
                  },
                ),
                const SizedBox(height: 16),
                if (isMobile) ...[
                  _QuickStatsCard(quick: payload.quick),
                  const SizedBox(height: 16),
                  _IntroductionCard(payload: payload),
                  const SizedBox(height: 16),
                  _ServicesCard(services: payload.services),
                  const SizedBox(height: 16),
                  _ReviewsCard(reviews: payload.reviews),
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            _ContactCard(contact: payload.contact),
                            const SizedBox(height: 16),
                            _QuickStatsCard(quick: payload.quick),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            _IntroductionCard(payload: payload),
                            const SizedBox(height: 16),
                            _ServicesCard(services: payload.services),
                            const SizedBox(height: 16),
                            _ReviewsCard(reviews: payload.reviews),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                _GalleryCard(services: payload.services),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final PublicProfileUserModel user;
  final VoidCallback onClose;

  const _Header({
    required this.user,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          _Avatar(url: user.avatarUrl, name: user.name, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: context.typography.base.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (user.isVerified) _Badge(label: 'verified'.tr),
                    if (user.isLegit) _Badge(label: 'trusted_partner'.tr),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user.joinedYear.isNotEmpty
                      ? 'member_since_year'.trParams({'year': user.joinedYear})
                      : 'member_label'.tr,
                  style: context.typography.xs.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            tooltip: 'close'.tr,
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final VoidCallback onReportPressed;

  const _ActionCard({required this.onReportPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onReportPressed,
        icon: const Icon(Icons.flag_outlined, size: 18),
        label: Text('report_this_user'.tr),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFDC2626),
          side: const BorderSide(color: Color(0xFFFECACA)),
          backgroundColor: const Color(0xFFFEF2F2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final PublicProfileContactModel? contact;

  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    final bool hasContact = contact?.hasData ?? false;
    return _SectionCard(
      title: 'contact'.tr,
      child: hasContact
          ? Column(
              children: [
                if (contact!.phone.trim().isNotEmpty)
                  _InfoLine(
                    label: 'phone_number'.tr,
                    value: contact!.phone,
                  ),
                if (contact!.phone.trim().isNotEmpty &&
                    contact!.email.trim().isNotEmpty)
                  const SizedBox(height: 12),
                if (contact!.email.trim().isNotEmpty)
                  _InfoLine(
                    label: 'email_address'.tr,
                    value: contact!.email,
                  ),
              ],
            )
          : _EmptyText(text: 'no_contact_info'.tr),
    );
  }
}

class _QuickStatsCard extends StatelessWidget {
  final PublicProfileQuickModel quick;

  const _QuickStatsCard({required this.quick});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'quick_stats'.tr,
      child: Column(
        children: [
          _InfoLine(
            label: 'orders_posted'.tr,
            value: quick.ordersPlaced.toString(),
          ),
          const SizedBox(height: 12),
          _InfoLine(
            label: 'completed_orders'.tr,
            value: quick.completedOrders.toString(),
          ),
          const SizedBox(height: 12),
          _InfoLine(
            label: 'cancellation_rate'.tr,
            value: '${quick.cancelledOrdersPct}%',
          ),
          const SizedBox(height: 12),
          _InfoLine(
            label: 'last_active'.tr,
            value: quick.lastActiveHuman.isNotEmpty
                ? quick.lastActiveHuman
                : '-',
            valueColor: const Color(0xFFE11D48),
          ),
        ],
      ),
    );
  }
}

class _IntroductionCard extends StatelessWidget {
  final PublicProfilePayloadModel payload;

  const _IntroductionCard({required this.payload});

  @override
  Widget build(BuildContext context) {
    final String introHtml = payload.introOrBio;

    return _SectionCard(
      title: 'introduction'.tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (introHtml.isEmpty)
            _EmptyText(text: 'profile_description_empty'.tr)
          else
            Html(
              data: introHtml,
              style: {
                'body': Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  color: const Color(0xFF374151),
                  fontSize: FontSize(14),
                  lineHeight: LineHeight(1.6),
                ),
                'p': Style(margin: Margins.only(bottom: 8)),
              },
            ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HighlightStat(
                    value: '${payload.quick.completedOrders}+',
                    label: 'completed_orders'.tr,
                  ),
                ),
                Expanded(
                  child: _HighlightStat(
                    value: '${payload.reviews.length}',
                    label: 'reviews_count_label'.tr,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesCard extends StatelessWidget {
  final List<PublicProfileServiceModel> services;

  const _ServicesCard({required this.services});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'services'.tr,
      child: services.isEmpty
          ? _EmptyText(text: 'public_profile_no_services'.tr)
          : Column(
              children: services
                  .map(
                    (service) => Container(
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
                                  service.name.isNotEmpty
                                      ? service.name
                                      : 'service'.tr,
                                  style: context.typography.sm.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                                if (service.category?.name.isNotEmpty ==
                                    true) ...[
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
                          Text(
                            'contact'.tr,
                            style: context.typography.sm.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE11D48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _ReviewsCard extends StatelessWidget {
  final List<PublicProfileReviewModel> reviews;

  const _ReviewsCard({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'customer_reviews'.tr,
      child: reviews.isEmpty
          ? _EmptyText(text: 'public_profile_no_reviews'.tr)
          : Column(
              children: reviews
                  .map(
                    (review) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  review.author.isNotEmpty
                                      ? review.author
                                      : 'anonymous_user'.tr,
                                  style: context.typography.sm.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              _RatingStars(rating: review.rating),
                            ],
                          ),
                          if (review.createdHuman.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              review.createdHuman,
                              style: context.typography.xs.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                          if (review.review.trim().isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              review.review.trim(),
                              style: context.typography.sm.copyWith(
                                color: const Color(0xFF374151),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final List<PublicProfileServiceModel> services;

  const _GalleryCard({required this.services});

  @override
  Widget build(BuildContext context) {
    final List<PublicProfileServiceModel> withImages = services
        .where((service) => service.images.isNotEmpty)
        .toList();

    return _SectionCard(
      title: 'service_images'.tr,
      child: withImages.isEmpty
          ? _EmptyText(text: 'public_profile_no_images'.tr)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: withImages
                  .map(
                    (service) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  service.name.isNotEmpty
                                      ? service.name
                                      : 'service'.tr,
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
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                            itemCount: service.images.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: service.images[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: const Color(0xFFF3F4F6),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: const Color(0xFFF3F4F6),
                                        child: const Icon(
                                          Icons.broken_image_outlined,
                                        ),
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.typography.base.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE11D48),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoLine({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.typography.sm.copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: context.typography.sm.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF111827),
            ),
          ),
        ),
      ],
    );
  }
}

class _HighlightStat extends StatelessWidget {
  final String value;
  final String label;

  const _HighlightStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.typography.xl.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFFE11D48),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.typography.xs.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _RatingStars extends StatelessWidget {
  final int rating;

  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final int safeRating = rating.clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < safeRating ? Icons.star_rounded : Icons.star_border_rounded,
          size: 16,
          color: const Color(0xFFF59E0B),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: context.typography.xs.copyWith(
          color: const Color(0xFF475569),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String url;
  final String name;
  final double size;

  const _Avatar({
    required this.url,
    required this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    _AvatarFallback(name: name),
              )
            : _AvatarFallback(name: name),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  final String name;

  const _AvatarFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    final String initial = name.trim().isEmpty
        ? '?'
        : name.trim().characters.first;
    return Center(
      child: Text(
        initial.toUpperCase(),
        style: context.typography.base.copyWith(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF6B7280),
        ),
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  final String text;

  const _EmptyText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.typography.sm.copyWith(
        color: Colors.grey[500],
        height: 1.5,
      ),
    );
  }
}
