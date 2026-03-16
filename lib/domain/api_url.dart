class AppUrl {
  static const String login = '/login';
  static const String registerClient = '/register';
  static const String registerPartner = '/register/partner';
  static const String checkToken = '/check-token';
  static const String locations = '/locations';
  static String wards(int provinceId) => '/locations/$provinceId/wards';
  static const String logout = '/logout';
  static const String partnerDashboard = '/partner/dashboard';

  // Client Home Screen APIs
  static const String homeSummary = '/event/home';
  static const String homeBlogs = '/blog/home';
  static const String partnerCategories = '/partner-categories';
  static String partnerCategoryDetail(String slug) => '/partner-categories/$slug';

  // Client Booking Screen APIs
  static const String quickBookingEventList = '/quick-booking/event-list';
  static const String quickBookingSave = '/quick-booking/save';

  // Client Order Screen APIs
  static const String clientOrders = '/orders';
  static const String clientHistoryOrders = '/orders/history';
  static String clientOrder(int id) => '/orders/$id';
  static String clientOrderDetail(int id) => '/orders/$id/details';
  static const String clientAssetOrders = '/asset-orders';
  static const String choosePartner = '/orders/choose-partner';
  static const String cancelOrder = '/orders/cancel';
  static const String reportBill = '/report/bill';
}
