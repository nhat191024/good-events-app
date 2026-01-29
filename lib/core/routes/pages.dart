import 'package:get/get.dart';

import 'package:sukientotapp/core/utils/import/screens.dart';
import 'package:sukientotapp/core/utils/import/binding.dart';

part 'routes.dart';

class Pages {
  Pages._();

  static const initialRoute = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.chooseYoSideScreen,
      page: () => const ChooseYoSideScreen(),
      binding: ChooseYoSideBinding(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    //Guest
    GetPage(
      name: Routes.guestHomeScreen,
      page: () => const GuestHomeScreen(),
      binding: GuestHomeBinding(),
    ),

    //Partner
    GetPage(
      name: Routes.partnerHome,
      page: () => const PartnerBottomNavigationView(),
      binding: PartnerBottomNavigationBinding(),
    ),
  ];
}
