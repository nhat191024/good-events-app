import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/client/home_repository.dart';

class HomeController extends GetxController {
  
  final HomeRepository _repository;
  HomeController(this._repository);
  

  final isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}