import 'package:sukientotapp/core/utils/import/global.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('histories'.tr, style: context.typography.lg));
  }
}
