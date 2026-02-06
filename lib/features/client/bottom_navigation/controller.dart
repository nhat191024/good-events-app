import 'package:sukientotapp/core/utils/import/global.dart';

class ClientBottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  var isReverse = false.obs;
  
  void setIndex(int index) {
    isReverse.value = index < currentIndex.value;
    currentIndex.value = index;
  }
}
