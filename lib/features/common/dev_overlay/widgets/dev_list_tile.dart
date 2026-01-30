import 'package:flutter/material.dart';
import 'package:sukientotapp/core/utils/app_colors.dart';

class DevListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool indented;

  const DevListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.indented = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    final child = ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
          fontFamily: 'Lexend',
          color: textColor,
        ),
      ),
      onTap: onTap,
    );

    if (!indented) return child;

    return Padding(padding: const EdgeInsets.only(left: 24.0), child: child);
  }
}
