import 'package:sukientotapp/core/utils/import/global.dart';

class PartnerBottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
  }
}
