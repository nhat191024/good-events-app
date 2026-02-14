part of 'pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = '/splash';
  static const chooseYoSideScreen = '/choose-yo-side';
  static const guestHomeScreen = '/guest/home';
  static const loginScreen = '/login';
  static const introduction = '/introduction';

  //Required Auth
  // Partner
  static const partnerHome = '/partner/home';

  // Client
  static const clientHome = '/client/home';
  static const partnerDetail = '/client/partner-detail';
}
