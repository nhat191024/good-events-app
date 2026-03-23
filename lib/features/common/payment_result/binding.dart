import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/partner/account_provider.dart';
import 'package:sukientotapp/data/repositories/partner/account_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';

class PaymentResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AccountProvider>(
      () => AccountProvider(Get.find<ApiService>()),
    );
    Get.lazyPut<AccountRepository>(
      () => AccountRepositoryImpl(Get.find<AccountProvider>()),
    );
    Get.lazyPut<PaymentResultController>(
      () => PaymentResultController(Get.find<AccountRepository>()),
    );
  }
}
