class AppUrl {
  static const String login = '/login';
  static const String registerClient = '/register';
  static const String registerPartner = '/register/partner';
  static const String checkToken = '/check-token';
  static const String locations = '/locations';
  static String wards(int provinceId) => '/locations/$provinceId/wards';
  static const String logout = '/logout';
}
