part of '../profile_preview.dart';

class _ReviewsCard extends StatelessWidget {
  final List<PublicProfileReviewModel> reviews;
  static const int _previewLimit = 3;

  const _ReviewsCard({required this.reviews});

  @override
  Widget build(BuildContext context) {
    final List<PublicProfileReviewModel> previewReviews = reviews
        .take(_previewLimit)
        .toList();
    final bool hasMore = reviews.length > _previewLimit;

    return _SectionCard(
      title: 'customer_reviews'.tr,
      child: reviews.isEmpty
          ? _EmptyText(text: 'public_profile_no_reviews'.tr)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...previewReviews.map(_buildReviewItem),
                if (hasMore) ...[
                  const SizedBox(height: 12),
                  _SeeMoreButton(
                    onPressed: () => _showReviewsBottomSheet(context),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildReviewItem(PublicProfileReviewModel review) {
    return Builder(
      builder: (context) => Container(
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
    );
  }

  void _showReviewsBottomSheet(BuildContext context) {
    _showPreviewBottomSheet(
      context,
      title: 'customer_reviews'.tr,
      child: Column(
        children: reviews.map(_buildReviewItem).toList(),
      ),
    );
  }
}
