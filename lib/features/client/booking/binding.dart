import 'package:get/get.dart';
import 'controller.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/client/booking_provider.dart';
import 'package:sukientotapp/domain/repositories/location_repository.dart';
import 'package:sukientotapp/data/repositories/location_repository_impl.dart';
import 'package:sukientotapp/data/providers/location_provider.dart';

class ClientBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<LocationProvider>(() => LocationProvider(Get.find<ApiService>()));
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl(Get.find<LocationProvider>()));

    Get.lazyPut<ClientBookingController>(
      () => ClientBookingController(
        BookingProvider(dio: Get.find<ApiService>().dio),
        Get.find<LocationRepository>(),
      ),
    );
  }
}
