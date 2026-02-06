import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class HomeScreen extends  GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('Home'),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Home Module')]),
    );
  }
}