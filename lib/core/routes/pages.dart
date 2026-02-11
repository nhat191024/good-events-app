import 'package:sukientotapp/core/utils/import/global.dart';
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

    //Partner Detail
    GetPage(
      name: Routes.partnerDetail,
      page: () => const PartnerDetailScreen(),
      binding: PartnerDetailBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ),

    GetPage(
      name: Routes.clientBooking,
      page: () => const ClientBooking(),
      binding: ClientBookingBinding(),
    ),
  ];
}
