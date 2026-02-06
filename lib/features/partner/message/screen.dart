import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class MessageScreen extends  GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('Message'),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Message Module')]),
    );
  }
}