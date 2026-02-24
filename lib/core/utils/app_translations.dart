import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': {
      //choose your side screen
      'title_choose_your_side': 'Bạn là khách hàng hay \nnhà cung cấp dịch vụ?',

      // introduction screen
      'client_step_1_intro': 'Sự kiện khó? Có Sự Kiện Tốt!',
      'client_step_2_intro': 'Bất cứ việc gì, bất cứ nơi đâu',
      'client_step_3_intro': 'Sự kiện lớn nhỏ? Dò đối tác ngay!',

      'partner_step_1_intro': 'Việc có liền tay, kết giao nhanh chóng',
      'partner_step_2_intro': 'Công việc linh động, cộng với mọi nơi',
      'partner_step_3_intro': 'Hỗ trợ liền kề, nâng cao tay nghề',

      //login screen
      'welcome_back': 'Chào mừng trở lại!',

      'username': 'Tên đăng nhập',
      'username_hint': 'Gmail hoặc số điện thoại',
      'username_invalid': 'Vui lòng nhập tên đăng nhập.',

      'password': 'Mật khẩu',
      'password_hint': '********',
      'password_invalid': 'Mật khẩu phải có ít nhất 8 ký tự.',

      'google_login': 'Đăng nhập với Google',
      'logging_loading': 'Đang đăng nhập...',

      //search hints
      'search_hint_1': 'Bạn đang tìm dịch vụ gì?',
      'search_hint_2': 'Bạn cần gì cho sự kiện của mình?',
      'search_hint_3': 'Đang có nhu cầu tổ chức sự kiện?',

      //guest
      'dont_have_account': 'Không có tài khoản sự kiện tốt?',
      'partner_register_now': 'Đăng ký để bắt đầu làm việc ngay hôm nay!',
      'customer_register_now': 'Đăng ký để trải nghiệm dịch vụ ngay hôm nay!',

      //partner home
      'quick_actions': 'Truy cập nhanh',
      'view_details': 'Xem chi tiết',
      'new_rate': '@rates Đánh giá mới',
      'from_clients': 'từ khách hàng',

      // client home
      'rent_product': 'Thiết bị sự kiện',
      'file_product': 'File thiết kế',
      'blog': 'Bài viết',
      'news_and_blogs': 'Tin tức bài viết',
      'see_more': 'Xem thêm',
      'partner_search': 'Tìm kiếm nhân sự đối tác',

      // client partner detail
      'contact': 'Liên hệ',
      'support': 'Hỗ trợ tư vấn',
      'rent': 'Thuê ngay',
      'book_now': 'Đặt lịch ngay',
      'main_info': 'Thông tin chính',
      'type': 'Loại',
      'field': 'Lĩnh vực',
      'partner_type': 'Loại đối tác',
      'rate': 'Đánh giá',
      'rate_count': '@rate đánh giá',
      'detailed_info': 'Thông tin chi tiết',
      'and': 'và',
      'about_the': 'về',
      'service': 'dịch vụ',
      'reference_price': 'Giá tham khảo',
      'contact_to_get_detail_and_best_deal': 'Liên hệ để nhận báo giá chi tiết và ưu đãi tốt nhất.',
      'partner_trustworthy': 'Đối tác uy tín, đã được xác minh.',
      'partner_professional': 'Phục vụ chuyên nghiệp, tận tâm.',
      'partner_competitive': 'Giá cả cạnh tranh, minh bạch.',

      //partner show
      'my_shows': 'Show của tôi',

      'news': 'Mới',
      'upcomings': 'Sắp tới',
      'histories': 'Lịch sử',

      //common
      'home': 'Trang chủ',
      'bills': 'Đơn',
      'messages': 'Tin nhắn',
      'account': 'Tài khoản',
      'search_with_dot': 'Tìm kiếm...',

      'wallet': 'Ví',
      'income': 'Thu nhập',

      'calendar': 'Lịch',

      'customer': 'Khách hàng',
      'partner': 'Đối tác sự kiện',
      'service_provider': 'Nhà cung cấp dịch vụ',

      'refresh': 'Làm mới',

      'last_update': 'Cập nhật lần cuối: @time',
      'time_ago': '@time trước',
      'date': 'Ngày',

      'address': 'Địa chỉ',

      'verified': 'Đã xác minh',

      'currency': 'VND',

      ///Show
      'take_order': 'Nhận show',
      'arrived': 'Đã đến nơi',
      'completed_show': 'Hoàn thành show',
      'waiting': 'Đang chờ',
      'wait_for_process': 'Chờ xử lý',
      'confirmed': 'Đã xác nhận',
      'completed': 'Hoàn thành',
      'expired': 'Hết hạn',
      'in_job': 'Đang thực hiện',
      'cancelled': 'Đã hủy',
      'new_show': 'Show mới',
      'pending': 'Đang chờ',
      'pending_order': 'Đơn đang chờ',
      'confirmed_order': 'Đơn đã xác nhận',
      'new_applicant': '@count nhân sự mới',
      'new_partner': '@count đối tác mới',
      'waiting_for_response': 'đang chờ phản hồi',
      'loading': 'Đang tải',
      'loading_with_dot': 'Đang tải...',

      'code': 'Mã',
      'event': 'Sự kiện',
      'start_time': 'Giờ bắt đầu',
      'end_time': 'Giờ kết thúc',
      'note': 'Ghi chú',
      'price': 'Giá',
      'your_price': 'Giá của bạn',

      'notification': 'Thông báo',
      'login_successful': 'Đăng nhập thành công! Welcome, @name.',

      ///New Show
      'accept_new_show': ' Nhận show mới',
      'accept_new_show_desc': 'Xem show mới theo thời gian thực.',

      'apply_for_show': 'Nhận show',
      'price_quote': 'Báo giá show',
      'price_quote_for_show': 'Báo giá cho show #@code',
      'input_price_quote': 'Nhập báo giá của bạn cho show này',

      'needs': 'Cần tìm',

      //messages
      'no_messages': 'Chưa có tin nhắn nào',
      'no_further_messages': 'Không còn tin nhắn nào nữa',

      'conversation': 'Cuộc trò chuyện',
      'type_a_message': 'Nhập tin nhắn...',

      //account
      'general_setting': 'Cài đặt chung',
      'more_setting': 'Cài đặt khác',

      'my_profile': 'Hồ sơ của tôi',
      'show_calendar': 'Lịch show',
      'my_services': 'Dịch vụ của tôi',
      'revenue_statistics': 'Thống kê doanh thu',
      'change_password': 'Đổi mật khẩu',
      'notification_setting': 'Cài đặt thông báo',
      'message_setting': 'Cài đặt tin nhắn',
      'report_problem': 'Báo cáo vấn đề',
      'privacy_policy': 'Chính sách bảo mật',
      'logout': 'Đăng xuất',

      'my_balance_wallet': 'Số dư ví',
      'add_balance': 'Nạp tiền',

      'cardholder_name': 'Tên chủ thẻ',
      'cardholder_hint': 'Nguyễn Văn A',
      'card_number': 'Số thẻ',
      'card_number_hint': '1234 5678 9012 3456',
      'expire_date': 'Ngày hết hạn',
      'cvv': 'CVV',
      'cvv_hint': '123',

      'no_transaction_history': 'Chưa có lịch sử giao dịch',
      'no_balance': 'Chưa có số dư',
      'no_balance_description_1': 'Số dư của bạn hiện là',
      "no_balance_description_2": "vui lòng nạp tiền vào ví.",

      ///Statuses
      'success': 'Thành công',
      'failed': 'Thất bại',
      'error': 'Lỗi',
      'info': 'Thông tin',

      //buttons
      'next': 'Tiếp theo',
      'register': 'Đăng ký',
      'login': 'Đăng nhập',
      'start_now': 'Bắt đầu ngay',
      'start': 'Bắt đầu',
      'previous': 'Trước',
      'skip': 'Bỏ qua',

      //dev
      'in_dev': 'Tính năng đang phát triển',
    },
    'en_US': {
      //choose your side screen
      'title_choose_your_side': 'Are you a customer or \na service provider?',

      // introduction screen
      'client_step_1_intro': 'Tough Event? We’ve Got You Covered!',
      'client_step_2_intro': 'Any Task, Any Place, Anytime',
      'client_step_3_intro': 'Big or Small? Find Partners Instantly!',

      'partner_step_1_intro': 'Get jobs instantly, connect fast',
      'partner_step_2_intro': 'Flexible. Work From Anywhere',
      'partner_step_3_intro': 'Hands-on Support, Level Up Your Skills',

      //login screen
      'welcome_back': 'Welcome Back!',

      'username': 'Username',
      'username_hint': 'Gmail or phone number',

      'password': 'Password',
      'password_hint': '********',
      'password_invalid': 'Password must be at least 8 characters long.',

      'google_login': 'Login with Google',
      'logging_loading': 'Logging in...',

      //search hints
      'search_hint_1': 'What service are you looking for?',
      'search_hint_2': 'What do you need for your event?',
      'search_hint_3': 'Are you planning an event?',

      //guest
      'dont_have_account': "Don't have a Sự kiện tốt account?",
      'partner_register_now': 'Register to start working today!',
      'customer_register_now': 'Register to experience the service today!',

      //partner home
      'quick_actions': 'Quick Actions',
      'view_details': 'View Details',
      'new_rate': '@rates New Reviews',
      'from_clients': 'from customers',

      // client home
      'rent_product': 'Event Rentals',
      'file_product': 'Digital Design Files',
      'blog': 'Blog',
      'news_and_blogs': 'News & Blogs',
      'see_more': 'See More',
      'partner_search': 'Partner Search',

      // client partner detail
      'contact': 'Contact',
      'support': 'Support',
      'rent': 'Rent',
      'book_now': 'Book now',
      'main_info': 'Main info',
      'type': 'Type',
      'field': 'Field',
      'partner_type': 'Partner type',
      'rate': 'Rate',
      'rate_count': '@rate ratings',
      'detailed_info': 'Detailed info',
      'and': 'and',
      'about_the': 'about the',
      'service': 'service',
      'reference_price': 'Reference price',
      'contact_to_get_detail_and_best_deal': 'Contact to get detail and best deal',
      'partner_trustworthy': 'A trusted partner, fully verified.',
      'partner_professional': 'Professional and dedicated service.',
      'partner_competitive': 'Competitive and transparent pricing.',

      //partner show
      'my_shows': 'My Shows',

      'news': 'News',
      'upcomings': 'Upcomings',
      'histories': 'Histories',

      //common
      'home': 'Home',
      'bills': 'Bills',
      'messages': 'Messages',
      'account': 'Account',
      'search_with_dot': 'Search...',

      'wallet': 'Ví',
      'income': 'Thu nhập',

      'calendar': 'Calendar',

      'customer': 'Customer',
      'partner': 'Partner',
      'service_provider': 'Service Provider',

      'refresh': 'Refresh',

      'last_update': 'Last update: @time',
      'time_ago': '@time ago',
      'date': 'Date',

      'address': 'Address',

      'verified': 'Verified',

      'currency': 'USD',

      ///Show
      'take_order': 'Take show',
      'arrived': 'Arrived',
      'completed_show': 'Completed show',
      'waiting': 'Waiting',
      'wait_for_process': 'Waiting for process',
      'confirmed': 'Confirmed',
      'completed': 'Completed',
      'expired': 'Expired',
      'in_job': 'In Job',
      'cancelled': 'Cancelled',
      'new_show': 'New Show',

      'code': 'Code',
      'event': 'Event',
      'start_time': 'Start Time',
      'end_time': 'End Time',
      'note': 'Note',
      'price': 'Price',
      'your_price': 'Your Price',

      'notification': 'Notification',
      'login_successful': 'Login successful! Welcome, @name.',

      'pending': 'Pending',
      'pending_order': 'Pending order',
      'confirmed_order': 'Confirmed order',
      'new_applicant': '@count New applicants',
      'new_partner': '@count New partners',
      'waiting_for_response': 'Waiting for response',
      'loading': 'Loading',
      'loading_with_dot': 'Loading...',

      ///New Show
      'accept_new_show': ' Accept New Show',
      'accept_new_show_desc': 'View new show in real time.',

      'apply_for_show': 'Apply for Show',
      'price_quote': 'Show price Quote',
      'price_quote_for_show': 'Price Quote for Show #@code',
      'input_price_quote': 'Input your price quote for this show',

      'needs': 'Needs',

      //messages
      'no_messages': 'No messages yet',
      'no_further_messages': 'No further messages',

      'conversation': 'Conversation',
      'type_a_message': 'Type a message...',

      //account
      'general_setting': 'General Setting',
      'more_setting': 'More Setting',

      'my_profile': 'My Profile',
      'show_calendar': 'Show Calendar',
      'my_services': 'My Services',
      'revenue_statistics': 'Revenue Statistics',
      'change_password': 'Change Password',
      'notification_setting': 'Notification Setting',
      'message_setting': 'Message Setting',
      'report_problem': 'Report a Problem',
      'privacy_policy': 'Privacy Policy',
      'logout': 'Logout',

      'my_balance_wallet': 'My Wallet Balance',
      'add_balance': 'Add Balance',
      'cardholder_name': 'Cardholder Name',
      'cardholder_hint': 'Nguyen Van A',
      'card_number': 'Card Number',
      'card_number_hint': '1234 5678 9012 3456',
      'expire_date': 'Expire Date',
      'cvv': 'CVV',
      'cvv_hint': '123',

      'no_transaction_history': 'No Transaction History',
      'no_balance': 'No Balance',
      'no_balance_description_1': 'Your current balance is',
      "no_balance_description_2": "please add balance to your wallet.",

      ///Statuses
      'success': 'Success',
      'failed': 'Failed',
      'error': 'Error',
      'info': 'Information',

      //buttons
      'next': 'Next',
      'register': 'Register',
      'login': 'Login',
      'start_now': 'Start Now',
      'start': 'Start',
      'previous': 'Previous',
      'skip': 'Skip',

      //dev
      'in_dev': 'Feature in development',
    },
  };
}
