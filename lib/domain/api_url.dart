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

  // Partner my shows
  static String partnerBills(String status) => '/partner/bills/$status';
  static const String partnerBillsHistory = '/partner/bills/history';
  static String partnerBillMarkInJob(int billId) => '/partner/bills/$billId/mark-in-job';
  static String partnerBillComplete(int billId) => '/partner/bills/$billId/complete';

  // Client Booking Screen APIs
  static const String quickBookingEventList = '/quick-booking/event-list';
  static const String quickBookingSave = '/quick-booking/save';

  // Client Order Screen APIs
  static const String clientOrders = '/orders';
  static const String clientHistoryOrders = '/orders/history';
  static String clientOrder(int id) => '/orders/$id';
  static String clientOrderDetail(int id) => '/orders/$id/details';
  static const String clientAssetOrders = '/asset-orders';
  static String clientHistoryOrder(int id) => '/orders/history/$id';

  static const String choosePartner = '/orders/choose-partner';
  static const String checkVoucherDiscount = '/orders/voucher-discount';
  static const String cancelOrder = '/orders/cancel';
  static const String reportBill = '/report/bill';
  static const String submitReview = '/orders/submit-review';
  static const String validateVoucher = '/orders/validate-voucher';

  // Chat / Threads
  static const String chats = '/chat';
  static String chatMessages(String threadId) => '/chat/threads/$threadId/messages';

  // Partner Services
  static const String partnerServices = '/partner/service/index';
  static const String partnerServiceCreate = '/partner/service';
  static String partnerServiceDetail(String id) => '/partner/service/$id';
  static String partnerServiceUpdate(String id) => '/partner/service/$id';
  static String partnerServiceImages(String id) => '/partner/service/$id/images';
  static String partnerServiceDeleteImage(String serviceId, String mediaId) =>
      '/partner/service/$serviceId/images/$mediaId';

  // Partner Categories
  static const String partnerServiceCategories = '/partner/category/index';

  // Profile
  static const String profile = '/profile/me';
  static const String updateProfile = '/profile/update';
  static const String updatePassword = '/profile/password';

  // Partner Wallet
  static const String partnerWalletTransactions = '/partner/wallet/transactions';
  static const String partnerWalletRegenerateAddFundsLink = '/partner/wallet/regenerate-add-funds-link';
  static const String partnerWalletConfirmAddFunds = '/partner/wallet/confirm-add-funds';

  // Partner Analytics
  static const String partnerAnalyticsStatistics = '/partner/analytics/statistics';
  static const String partnerAnalyticsRevenueChart = '/partner/analytics/revenue-chart';
  static const String partnerAnalyticsTopServices = '/partner/analytics/top-services';
}
