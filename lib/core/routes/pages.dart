import 'package:get/get.dart';

import 'package:sukientotapp/core/utils/import/screens.dart';
import 'package:sukientotapp/core/utils/import/binding.dart';
import 'package:sukientotapp/features/common/introduction/binding.dart';
import 'package:sukientotapp/features/common/introduction/screen.dart';

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
      name: Routes.introduction,
      page: () => const IntroductionScreen(),
      binding: IntroductionBinding(),
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

    //Client
    GetPage(
      name: Routes.clientHome,
      page: () => const ClientBottomNavigationView(),
      binding: ClientBottomNavigationBinding(),
    ),
  ];
}
