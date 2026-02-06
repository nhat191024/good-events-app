import 'package:sukientotapp/core/utils/import/global.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('news'.tr, style: context.typography.lg));
  }
}
