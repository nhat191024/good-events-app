import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': {
      //choose your side screen
      'title_choose_your_side': 'Bạn là khách hàng hay \nnhà cung cấp dịch vụ?',

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

      //guest
      'dont_have_account': 'Không có tài khoản sự kiện tốt?',
      'partner_register_now': 'Đăng ký để bắt đầu làm việc ngay hôm nay!',
      'customer_register_now': 'Đăng ký để trải nghiệm dịch vụ ngay hôm nay!',

      //common
      'home' : 'Trang chủ',
      'customer': 'Khách hàng',
      'partner': 'Đối tác',
      'service_provider': 'Nhà cung cấp dịch vụ',
      'notification': 'Thông báo',

      //buttons
      'next': 'Tiếp theo',
      'register': 'Đăng ký',
      'login': 'Đăng nhập',

      //dev
      'in_dev': 'Tính năng đang phát triển',
    },
    'en_US': {
      //choose your side screen
      'title_choose_your_side': 'Are you a customer or \na service provider?',

      //login screen
      'welcome_back': 'Welcome Back!',

      'username': 'Username',
      'username_hint': 'Gmail or phone number',

      'password': 'Password',
      'password_hint': '********',
      'password_invalid': 'Password must be at least 8 characters long.',

      'google_login': 'Login with Google',
      'logging_loading': 'Logging in...',

      //guest
      'dont_have_account': "Don't have a Sự kiện tốt account?",
      'partner_register_now': 'Register to start working today!',
      'customer_register_now': 'Register to experience the service today!',

      //common
      'home' : 'Home',
      'customer': 'Customer',
      'partner': 'Partner',
      'service_provider': 'Service Provider',
      'notification': 'Notification',

      //buttons
      'next': 'Next',
      'register': 'Register',
      'login': 'Login',

      //dev
      'in_dev': 'Feature in development',
    },
  };
}
