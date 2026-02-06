import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';
import 'package:sukientotapp/data/repositories/partner/new_show_repository_impl.dart';

class NewShowBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    //Remmber to register a provider if needed (99% u will need it)

    Get.lazyPut<NewShowRepository>(() => NewShowRepositoryImpl(/*Provider Get.find here*/));

    Get.lazyPut<NewShowController>(() => NewShowController(Get.find<NewShowRepository>()));
    
    
  }
}