import 'package:sukientotapp/features/partner/home/home_controller.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Center(
        child: Text('partner_home_welcome'.tr, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
