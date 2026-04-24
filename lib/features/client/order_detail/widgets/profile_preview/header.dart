part of '../profile_preview.dart';

class _Header extends StatelessWidget {
  final PublicProfileUserModel user;
  final String avatarUrl;
  final VoidCallback onClose;

  const _Header({
    required this.user,
    required this.avatarUrl,
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
          _Avatar(url: avatarUrl, name: user.name, size: 40),
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
