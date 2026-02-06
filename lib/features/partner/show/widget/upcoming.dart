import 'package:sukientotapp/core/utils/import/global.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('upcomings'.tr, style: context.typography.lg));
  }
}
