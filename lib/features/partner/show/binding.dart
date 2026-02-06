import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';
import 'package:sukientotapp/data/repositories/partner/show_repository_impl.dart';

class ShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    //Remmber to register a provider if needed (99% u will need it)

    Get.lazyPut<ShowRepository>(() => ShowRepositoryImpl(/*Provider Get.find here*/));

    Get.lazyPut<ShowController>(() => ShowController(Get.find<ShowRepository>()));
  }
}
