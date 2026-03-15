class AppUrl {
  // Authentication
  static const String login = '/login';
  static const String registerClient = '/register';
  static const String registerPartner = '/register/partner';
  static const String checkToken = '/check-token';
  static const String logout = '/logout';

  // Location APIs
  static const String locations = '/locations';
  static String wards(int provinceId) => '/locations/$provinceId/wards';

  // Partner Dashboard
  static const String partnerDashboard = '/partner/dashboard';

  // Client Home Screen APIs
  static const String homeSummary = '/event/home';
  static const String homeBlogs = '/blog/home';
  static const String partnerCategories = '/partner-categories';
  static String partnerCategoryDetail(String slug) => '/partner-categories/$slug';

  // Partner New Show
  static const String partnerBillsRealtime = '/partner/bills/realtime';
  static String partnerBillAccept(int billId) => '/partner/bills/$billId/accept';

  // Partner Show List (filtered by status)
  static String partnerBills(String status) => '/partner/bills/$status';

  // Partner Show History
  static const String partnerBillsHistory = '/partner/bills/history';
}
