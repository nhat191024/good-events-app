import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';

class AccountController extends GetxController {
  
  final AccountRepository _repository;
  AccountController(this._repository);
  

  final isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}