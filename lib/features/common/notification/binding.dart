import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/notification/controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
