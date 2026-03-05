import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/partner/message_repository.dart';
import 'package:sukientotapp/data/repositories/partner/message_repository_impl.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    //Remmber to register a provider if needed (99% u will need it)

    Get.lazyPut<MessageRepository>(() => MessageRepositoryImpl(/*Provider Get.find here*/));

    Get.lazyPut<MessageController>(() => MessageController(Get.find<MessageRepository>()));
    
    
  }
}