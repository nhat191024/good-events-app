import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';
import 'package:sukientotapp/data/repositories/client/home_repository_impl.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    //Remmber to register a provider if needed (99% u will need it)

    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(/*Provider Get.find here*/));

    Get.lazyPut<HomeController>(() => HomeController(Get.find<HomeRepository>()));
    
    
  }
}