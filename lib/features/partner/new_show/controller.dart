import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowController extends GetxController {
  
  final NewShowRepository _repository;
  NewShowController(this._repository);
  

  final isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}