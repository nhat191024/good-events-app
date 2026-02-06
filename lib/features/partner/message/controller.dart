import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/message_repository.dart';

class MessageController extends GetxController {
  
  final MessageRepository _repository;
  MessageController(this._repository);
  

  final isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}