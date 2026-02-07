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

      ///Show
      'take_order': 'Nhận show',
      'waiting': 'Đang chờ',
      'confirmed': 'Đã xác nhận',
      'new_show': 'Show mới',
      'pending': 'Đang chờ',
      'pending_order': 'Đơn đang chờ',
      'confirmed_order': 'Đơn đã xác nhận',
      'new_applicant': '@count nhân sự mới',
      'new_partner': '@count đối tác mới',
      'waiting_for_response': 'đang chờ phản hồi',

      'code': 'Mã',
      'event': 'Sự kiện',
      'start_time': 'Giờ bắt đầu',
      'end_time': 'Giờ kết thúc',
      'note': 'Ghi chú',
      'price': 'Giá',

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

      ///Show
      'take_order': 'Take show',
      'waiting': 'Waiting',
      'confirmed': 'Confirmed',
      'new_show': 'New Show',

      'code': 'Code',
      'event': 'Event',
      'start_time': 'Start Time',
      'end_time': 'End Time',
      'note': 'Note',
      'price': 'Price',

      'notification': 'Notification',
      'login_successful': 'Login successful! Welcome, @name.',

      'pending': 'Pending',
      'pending_order': 'Pending order',
      'confirmed_order': 'Confirmed order',
      'new_applicant': '@count New applicants',
      'new_partner': '@count New partners',
      'waiting_for_response': 'Waiting for response',

      ///New Show
      'accept_new_show': ' Accept New Show',
      'accept_new_show_desc': 'View new show in real time.',

      'apply_for_show': 'Apply for Show',
      'price_quote': 'Show price Quote',
      'price_quote_for_show': 'Price Quote for Show #@code',
      'input_price_quote': 'Input your price quote for this show',

      'needs': 'Needs',

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
