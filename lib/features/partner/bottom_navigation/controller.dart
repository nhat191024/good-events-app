import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/show/controller.dart';

class PartnerBottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  var isReverse = false.obs;

  final ShowController showController = Get.find<ShowController>();

  void setIndex(int index, {int? setTab}) {
    isReverse.value = index < currentIndex.value;
    currentIndex.value = index;

    if (index == 1 && setTab != null) {
      if (Get.isRegistered<ShowController>()) {
        final showController = Get.find<ShowController>();
        showController.switchTab(setTab);
      } else {}
    }
  }
}
