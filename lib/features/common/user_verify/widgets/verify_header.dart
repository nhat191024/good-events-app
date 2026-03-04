import 'package:sukientotapp/core/utils/import/global.dart';

class VerifyHeader extends StatelessWidget {
  final Widget title;
  final Widget subtitle;

  VerifyHeader({super.key, required String title, required String subtitle})
    : title = Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      subtitle = Text(subtitle, style: const TextStyle(fontSize: 13));

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png', width: 40, height: 40),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                child: title,
              ),
              const SizedBox(height: 4),
              DefaultTextStyle(
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                child: subtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
