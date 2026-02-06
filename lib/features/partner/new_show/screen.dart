import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class NewShowScreen extends  GetView<NewShowController> {
  const NewShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('NewShow'),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('NewShow Module')]),
    );
  }
}