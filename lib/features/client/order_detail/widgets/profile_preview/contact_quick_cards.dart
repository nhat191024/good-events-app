part of '../profile_preview.dart';

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
            value: quick.lastActiveHuman.isNotEmpty ? quick.lastActiveHuman : '-',
            valueColor: const Color(0xFFE11D48),
          ),
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
