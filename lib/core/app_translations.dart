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

      'login_button': 'Đăng nhập',
      'google_login': 'Đăng nhập với Google',
      'logging_loading': 'Đang đăng nhập...',

      //common
      'home' : 'Trang chủ',
      'customer': 'Khách hàng',
      'partner': 'Đối tác',
      'service_provider': 'Nhà cung cấp dịch vụ',

      //buttons
      'next': 'Tiếp theo',
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

      'login_button': 'Login',
      'google_login': 'Login with Google',
      'logging_loading': 'Logging in...',

      //common
      'customer': 'Customer',
      'service_provider': 'Service Provider',

      //buttons
      'next': 'Next',
    },
  };
}
