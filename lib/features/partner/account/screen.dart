import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class AccountScreen extends  GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('Account'),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Account Module')]),
    );
  }
}