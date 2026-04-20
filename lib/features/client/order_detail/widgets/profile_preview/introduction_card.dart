part of '../profile_preview.dart';

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
