import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/user_verify/controller.dart';

class VerifyMethodCard extends StatelessWidget {
  final VerifyMethod method;
  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const VerifyMethodCard({
    super.key,
    required this.method,
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.fTheme.colors.primary;
    final border = context.fTheme.colors.border;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? primary : border,
            width: selected ? 2 : 1.5,
          ),
          color: selected
              ? primary.withValues(alpha: 0.05)
              : context.fTheme.colors.background,
        ),
        child: Row(
          children: [
            // Icon circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? primary
                    : context.fTheme.colors.secondary.withValues(alpha: 0.15),
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected
                    ? Colors.white
                    : context.fTheme.colors.mutedForeground,
              ),
            ),
            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Checkmark
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: selected ? 1 : 0,
              child: Icon(Icons.check_circle_rounded, color: primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
