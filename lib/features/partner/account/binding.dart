import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';
import 'package:sukientotapp/data/repositories/partner/account_repository_impl.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    //Remmber to register a provider if needed (99% u will need it)

    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(/*Provider Get.find here*/));

    Get.lazyPut<AccountController>(() => AccountController(Get.find<AccountRepository>()));
    
    
  }
}