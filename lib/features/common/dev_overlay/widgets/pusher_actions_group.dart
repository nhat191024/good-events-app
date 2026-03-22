import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sukientotapp/core/services/pusher_service.dart';
import 'package:sukientotapp/core/utils/app_colors.dart';

import 'dev_list_tile.dart';

class PusherActionsGroup extends StatelessWidget {
  const PusherActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(Icons.cable, color: AppColors.primary),
        title: Text(
          'Pusher Actions',
          style: (Theme.of(context).textTheme.titleMedium ?? const TextStyle())
              .copyWith(
                fontFamily: 'Lexend',
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
        ),
        children: [
          DevListTile(
            indented: true,
            icon: Icons.list_alt_outlined,
            title: 'Active Connections',
            onTap: () => _showActiveConnections(context),
          ),
        ],
      ),
    );
  }

  void _showActiveConnections(BuildContext context) {
    Get.bottomSheet(const _PusherConnectionsSheet(), isScrollControlled: true);
  }
}

class _PusherConnectionsSheet extends StatefulWidget {
  const _PusherConnectionsSheet();

  @override
  State<_PusherConnectionsSheet> createState() =>
      _PusherConnectionsSheetState();
}

class _PusherConnectionsSheetState extends State<_PusherConnectionsSheet> {
  String? _socketId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSocketId();
  }

  Future<void> _loadSocketId() async {
    final socketId = await PusherService.getSocketId();
    if (mounted) {
      setState(() {
        _socketId = socketId;
        _loading = false;
      });
    }
  }

  Color _stateColor(String state) {
    return switch (state.toUpperCase()) {
      'CONNECTED' => Colors.green,
      'CONNECTING' || 'RECONNECTING' => Colors.orange,
      _ => Colors.red,
    };
  }

  @override
  Widget build(BuildContext context) {
    final state = PusherService.connectionState;
    final channels = PusherService.channels.toList()..sort();
    final stateColor = _stateColor(state);
    final textTheme = Theme.of(context).textTheme;
    final textColor = textTheme.bodyMedium?.color ?? Colors.black;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.cable, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Pusher Connections',
                  style: (textTheme.titleLarge ?? const TextStyle()).copyWith(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Connection State
            _InfoRow(
              label: 'State',
              value: state,
              valueColor: stateColor,
              icon: Icons.circle,
              iconColor: stateColor,
            ),

            const SizedBox(height: 8),

            // Socket ID
            _InfoRow(
              label: 'Socket ID',
              value: _loading ? 'Loading...' : (_socketId ?? 'N/A'),
              icon: Icons.tag,
            ),

            const Divider(height: 24),

            // Channels header
            Row(
              children: [
                Icon(
                  Icons.layers_outlined,
                  size: 16,
                  color: textColor.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Text(
                  'Subscribed Channels (${channels.length})',
                  style: (textTheme.labelLarge ?? const TextStyle()).copyWith(
                    fontFamily: 'Lexend',
                    color: textColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Channels list
            Flexible(
              child: channels.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'No active channel subscriptions',
                        style: (textTheme.bodyMedium ?? const TextStyle())
                            .copyWith(
                              fontFamily: 'Lexend',
                              color: textColor.withValues(alpha: 0.5),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: channels.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final ch = channels[index];
                        final isPrivate = ch.startsWith('private-');
                        final isPresence = ch.startsWith('presence-');
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            isPresence
                                ? Icons.group_outlined
                                : isPrivate
                                ? Icons.lock_outline
                                : Icons.public_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            ch,
                            style: (textTheme.bodySmall ?? const TextStyle())
                                .copyWith(
                                  fontFamily: 'Lexend',
                                  color: textColor,
                                ),
                          ),
                          subtitle: Text(
                            isPresence
                                ? 'presence'
                                : isPrivate
                                ? 'private'
                                : 'public',
                            style: (textTheme.labelSmall ?? const TextStyle())
                                .copyWith(
                                  fontFamily: 'Lexend',
                                  color: textColor.withValues(alpha: 0.5),
                                ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? icon;
  final Color? iconColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = textTheme.bodyMedium?.color ?? Colors.black;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: iconColor ?? AppColors.primary),
          const SizedBox(width: 6),
        ],
        Text(
          '$label: ',
          style: (textTheme.bodyMedium ?? const TextStyle()).copyWith(
            fontFamily: 'Lexend',
            color: textColor.withValues(alpha: 0.6),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: (textTheme.bodyMedium ?? const TextStyle()).copyWith(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              color: valueColor ?? textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
