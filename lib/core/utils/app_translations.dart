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

      //register screen
      'create_account': 'Tạo tài khoản',
      'full_name': 'Họ và tên',
      'name_hint': 'Nhập họ và tên đầy đủ',
      'email_address': 'Địa chỉ email',
      'email_hint': 'email@vídụ.com',
      'phone_number': 'Số điện thoại',
      'phone_hint': '0987654321',
      'identity_card_number': 'Số CCCD',
      'cccd_hint': '034758372993',
      'password_confirmation': 'Xác nhận mật khẩu',
      'password_confirmation_hint': 'Nhập lại mật khẩu',
      'password_mismatch_error': 'Mật khẩu không khớp.',
      'search': 'Tìm kiếm...',
      'province_city': 'Tỉnh thành',
      'select_province_hint': 'Chọn Khu vực hoạt động của bạn...',
      'ward_district': 'Phường, Huyện',
      'select_ward_hint': 'Chọn xã, phường...',
      'creating_account_loading': 'Đang tạo tài khoản...',
      'create_account_btn': 'Tạo tài khoản',
      'name_invalid': 'Vui lòng nhập họ và tên.',
      'email_invalid': 'Vui lòng nhập email hợp lệ.',
      'phone_invalid': 'Vui lòng nhập số điện thoại hợp lệ.',
      'cccd_invalid': 'Vui lòng nhập số CCCD hợp lệ.',
      'register_successful': 'Đăng ký thành công!',
      'please_select_location': 'Vui lòng chọn khu vực của bạn.',
      'failed_to_load_provinces': 'Không thể tải danh sách tỉnh thành.',
      'failed_to_load_wards': 'Không thể tải danh sách quận huyện.',

      // verify screen
      'verify_account_title': 'Xác thực tài khoản',
      'verify_account_subtitle':
          'Chọn phương thức bạn muốn dùng để xác thực tài khoản.',
      'verify_via_email': 'Xác thực qua Email',
      'verify_via_zalo': 'Xác thực qua Zalo',
      'verify_zalo_subtitle': 'Gửi mã OTP đến @phone',
      'verify_email_title': 'Xác thực Email',
      'verify_phone_title': 'Xác thực Số điện thoại',
      'verify_email_otp_subtitle':
          'Chúng tôi đã gửi mã OTP đến địa chỉ email của bạn. Vui lòng nhập mã để xác thực.',
      'verify_phone_otp_subtitle':
          'Chúng tôi đã gửi mã OTP qua tin nhắn Zalo đến số điện thoại của bạn. Vui lòng nhập mã để xác thực.',
      'enter_otp': 'Nhập mã OTP',
      'continue_btn': 'Tiếp tục',
      'verify_btn': 'Xác thực',
      'verifying': 'Đang xác thực...',
      'resend_otp': 'Gửi lại mã OTP',
      'back_to_method': 'Quay lại chọn phương thức',
      'otp_invalid': 'Vui lòng nhập đúng mã OTP 6 số.',
      'verify_success': 'Xác thực thành công!',
      'otp_resent': 'Đã gửi lại mã OTP.',

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
      'contact_to_get_detail_and_best_deal':
          'Liên hệ để nhận báo giá chi tiết và ưu đãi tốt nhất.',
      'partner_trustworthy': 'Đối tác uy tín, đã được xác minh.',
      'partner_professional': 'Phục vụ chuyên nghiệp, tận tâm.',
      'partner_competitive': 'Giá cả cạnh tranh, minh bạch.',

      // client booking
      'booking_title': 'Đặt show',
      'booking_subtitle': 'Vui lòng điền thông tin để đặt show của bạn.',
      'booking_start_time': 'Thời gian bắt đầu',
      'booking_end_time': 'Thời gian kết thúc',
      'booking_time_placeholder': 'hh:mm',
      'booking_event_date': 'Ngày tổ chức sự kiện',
      'booking_date_placeholder': 'dd/mm/yyyy',
      'booking_event_type': 'Nội dung sự kiện',
      'booking_event_type_placeholder': 'Chọn nội dung sự kiện',
      'booking_event_custom': 'Nội dung sự kiện (Tùy chọn)',
      'booking_event_custom_placeholder': 'VD: Tổ chức thăm lăng bác',
      'booking_note_optional': 'Ghi chú bổ sung (Tùy chọn)',
      'booking_note_placeholder':
          'VD: Cần người mặc đồng phục có tông màu vàng',
      'booking_location': 'Địa điểm tổ chức',
      'booking_location_ward': 'Phường/Xã',
      'booking_select_province': 'Chọn tỉnh/thành',
      'booking_select_ward': 'Chọn phường/xã',
      'booking_address_detail': 'Địa chỉ chi tiết',
      'booking_address_placeholder': 'Số nhà, đường...',
      'booking_back': 'Làm lại từ đầu',
      'booking_submit': 'Đặt show ngay',
      'booking_success': 'Đặt lịch thành công!',
      'please_wait': 'Vui lòng chờ...',
      'event_type_custom': 'Nhập giá trị tùy chỉnh',
      'event_type_wedding': 'Tiệc cưới',
      'event_type_conference': 'Hội nghị',
      'event_type_birthday': 'Sinh nhật',
      'booking_stage_time_title': 'Chọn thời gian',
      'booking_stage_time_subtitle':
          'Chọn giờ bắt đầu, kết thúc và ngày tổ chức.',
      'booking_stage_event_title': 'Nội dung sự kiện',
      'booking_stage_event_subtitle':
          'Cho biết nội dung hoặc ghi chú cần thiết.',
      'booking_stage_location_title': 'Địa điểm tổ chức',
      'booking_stage_location_subtitle':
          'Chọn khu vực và nhập địa chỉ chi tiết.',
      'start_over': 'Bắt đầu lại',

      // client order
      'my_orders': 'Đơn hàng của tôi',
      'event_orders': 'Đơn sự kiện',
      'asset_orders': 'File đã mua',

      // Event Orders - Tabs
      'current_orders': 'Đơn hiện tại',
      'history': 'Lịch sử',

      // Event Orders - Status
      'status_pending': 'Đang chờ',
      'status_confirmed': 'Đã chốt',
      'status_in_job': 'Đã đến nơi',
      'status_completed': 'Hoàn thành',
      'status_cancelled': 'Đã hủy',

      // Event Orders - Filters
      'search_orders': 'Tìm kiếm đơn hàng...',
      'sort_by': 'Sắp xếp theo',
      'sort_newest': 'Đơn sắp tới',
      'sort_oldest': 'Đơn muộn nhất',
      'sort_most_applicants': 'Nhiều ứng viên nhất',
      'sort_highest_budget': 'Ngân sách cao nhất',
      'sort_lowest_budget': 'Ngân sách thấp nhất',
      'orders_count': '@count đơn',
      'orders_label': 'Đơn sự kiện',
      'current_yours': 'HIỆN TẠI CỦA BẠN',

      // Event Orders - Content
      'viewing': 'Đang xem',
      'final_price': 'Giá chốt',
      'event_at': 'Tổ chức ngày @day, @date từ lúc @start đến @end',
      'note_label': 'Ghi chú',
      'at_location': 'Ở @address',

      // Asset Orders - Tabs
      'all_orders': 'Tất cả',
      'pending_status': 'Chờ xử lý',
      'paid_status': 'Đã thanh toán',
      'cancelled_status': 'Đã hủy',

      // Asset Orders - Content
      'purchased_designs': 'File - Tài liệu đã mua',
      'category_label': 'Danh mục',
      'load_more_orders': 'Xem thêm đơn hàng',

      // Empty States
      'no_current_orders': 'Bạn chưa có đơn hiện tại',
      'no_history_orders': 'Bạn chưa có lịch sử đơn hàng',
      'no_asset_orders': 'Bạn chưa mua thiết kế nào',
      'no_pending_asset_orders': 'Không có đơn chờ xử lý',
      'no_paid_asset_orders': 'Không có đơn đã thanh toán',
      'no_cancelled_asset_orders': 'Không có đơn đã hủy',
      'no_bills': 'Chưa có đơn hàng nào',

      //partner show
      'my_shows': 'Show của tôi',

      'news': 'Mới',
      'upcomings': 'Sắp tới',
      'histories': 'Lịch sử',

      'detail_info': 'Thông tin chi tiết',

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

      'click_to_upload': 'Nhấn để tải ảnh lên',
      'upload_description': 'PNG, JPG, JPEG, WEBP (Tối đa 5MB)',

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

      'upload_arrived_photo': 'Tải ảnh đã đến nơi',
      'upload_arrived_photo_desc':
          'Tải ảnh lên để xác nhận bạn đã đến địa điểm.',

      'confirm_complete': 'Xác nhận hoàn thành',
      'confirm_complete_message':
          'Bạn có chắc chắn muốn đánh dấu đơn này là đã hoàn thành?',

      'complete_bill_success': 'Đơn đã được hoàn thành!',
      'insufficient_balance': 'Số dư không đủ để hoàn thành đơn!',

      'code': 'Mã',
      'status': 'Trạng thái',
      'time': 'Thời gian',
      'location': 'Địa điểm',
      'event': 'Sự kiện',
      'start_time': 'Giờ bắt đầu',
      'end_time': 'Giờ kết thúc',
      'note': 'Ghi chú',
      'price': 'Giá',
      'your_price': 'Giá của bạn',

      'total_price': 'Tổng giá',

      'notification': 'Thông báo',
      'login_successful': 'Đăng nhập thành công! Welcome, @name.',

      ///New Show
      'accept_new_show': ' Nhận show mới',
      'accept_new_show_desc': 'Xem show mới theo thời gian thực.',

      'apply_for_show': 'Nhận show',
      'price_quote': 'Báo giá show',
      'price_quote_for_show': 'Báo giá cho show #@code',
      'input_price_quote': 'Nhập giá của bạn',

      'invalid_price': 'Vui lòng nhập giá hợp lệ (tối thiểu @min)',
      'accepted_show': 'Bạn đã nhận show #@code',
      'failed_to_accept_show': 'Không thể nhận show, vui lòng thử lại',

      'needs': 'Cần tìm',

      //messages
      'no_messages': 'Chưa có tin nhắn nào',
      'no_further_messages': 'Không còn tin nhắn nào nữa',

      'bill_info': 'Thông tin đơn hàng',

      'conversation': 'Cuộc trò chuyện',
      'type_a_message': 'Nhập tin nhắn...',

      //times
      'just_now': 'vừa xong',
      'minute_ago': '@count phút trước',
      'minutes_ago': '@count phút trước',
      'hour_ago': '@count giờ trước',
      'hours_ago': '@count giờ trước',
      'day_ago': '@count ngày trước',
      'days_ago': '@count ngày trước',
      'month_ago': '@count tháng trước',
      'months_ago': '@count tháng trước',
      'year_ago': '@count năm trước',
      'years_ago': '@count năm trước',

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

      'forbidden': 'Không có quyền',
      'not_found': 'Không tìm thấy',
      'invalid_request': 'Yêu cầu không hợp lệ',

      //buttons
      'next': 'Tiếp theo',
      'register': 'Đăng ký',
      'login': 'Đăng nhập',
      'start_now': 'Bắt đầu ngay',
      'start': 'Bắt đầu',
      'previous': 'Trước',
      'skip': 'Bỏ qua',
      'cancel': 'Hủy',
      'done': 'Xong',
      'confirm': 'Xác nhận',
      'take_photo': 'Chụp ảnh',
      'complete': 'Hoàn thành',

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

      //register screen
      'create_account': 'Create Account',
      'full_name': 'Full Name',
      'name_hint': 'Enter your full name',
      'email_address': 'Email Address',
      'email_hint': 'email@example.com',
      'phone_number': 'Phone Number',
      'phone_hint': '0987654321',
      'identity_card_number': 'Identity Card Number',
      'cccd_hint': '034758372993',
      'password_confirmation': 'Confirm Password',
      'password_confirmation_hint': 'Re-enter password',
      'password_mismatch_error': 'Passwords do not match.',
      'search': 'Search...',
      'province_city': 'Province / City',
      'select_province_hint': 'Select your operating area...',
      'ward_district': 'Ward / District',
      'select_ward_hint': 'Select ward, district...',
      'creating_account_loading': 'Creating account...',
      'create_account_btn': 'Create Account',
      'name_invalid': 'Please enter your full name.',
      'email_invalid': 'Please enter a valid email.',
      'phone_invalid': 'Please enter a valid phone number.',
      'cccd_invalid': 'Please enter a valid ID card number.',
      'register_successful': 'Registration successful!',
      'please_select_location': 'Please select your operating area.',
      'failed_to_load_provinces': 'Failed to load provinces.',
      'failed_to_load_wards': 'Failed to load wards.',

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
      'contact_to_get_detail_and_best_deal':
          'Contact to get detail and best deal',
      'partner_trustworthy': 'A trusted partner, fully verified.',
      'partner_professional': 'Professional and dedicated service.',
      'partner_competitive': 'Competitive and transparent pricing.',

      // client booking
      'booking_title': 'Book a Show',
      'booking_subtitle': 'Fill in the details to book your event.',
      'booking_start_time': 'Start time',
      'booking_end_time': 'End time',
      'booking_time_placeholder': 'hh:mm',
      'booking_event_date': 'Event date',
      'booking_date_placeholder': 'dd/mm/yyyy',
      'booking_event_type': 'Event type',
      'booking_event_type_placeholder': 'Select event type',
      'booking_event_custom': 'Event details (Optional)',
      'booking_event_custom_placeholder':
          "e.g., Visit the President's Mausoleum",
      'booking_note_optional': 'Additional notes (Optional)',
      'booking_note_placeholder': 'e.g., Need staff with yellow uniforms',
      'booking_location': 'Location',
      'booking_location_ward': 'Ward',
      'booking_select_province': 'Select province/city',
      'booking_select_ward': 'Select ward',
      'booking_address_detail': 'Detailed address',
      'booking_address_placeholder': 'Street, building...',
      'booking_back': 'Start over',
      'booking_submit': 'Book now',
      'booking_success': 'Booking successful!',
      'please_wait': 'Please wait...',
      'event_type_custom': 'Custom input',
      'event_type_wedding': 'Wedding',
      'event_type_conference': 'Conference',
      'event_type_birthday': 'Birthday',
      'booking_stage_time_title': 'Select time',
      'booking_stage_time_subtitle': 'Pick start/end time and event date.',
      'booking_stage_event_title': 'Event details',
      'booking_stage_event_subtitle':
          'Describe the event and add notes if needed.',
      'booking_stage_location_title': 'Select location',
      'booking_stage_location_subtitle':
          'Choose area and enter detailed address.',
      'start_over': 'Start over',

      // client order
      'my_orders': 'My Orders',
      'event_orders': 'Event Orders',
      'asset_orders': 'Asset Orders',

      // Event Orders - Tabs
      'current_orders': 'Current Orders',
      'history': 'History',

      // Event Orders - Status
      'status_pending': 'Pending',
      'status_confirmed': 'Confirmed',
      'status_in_job': 'At Location',
      'status_completed': 'Completed',
      'status_cancelled': 'Cancelled',

      // Event Orders - Filters
      'search_orders': 'Search orders...',
      'sort_by': 'Sort by',
      'sort_newest': 'Upcoming Orders',
      'sort_oldest': 'Latest Orders',
      'sort_most_applicants': 'Most Applicants',
      'sort_highest_budget': 'Highest Budget',
      'sort_lowest_budget': 'Lowest Budget',
      'orders_count': '@count orders',
      'orders_label': 'Orders',
      'current_yours': 'CURRENT OF YOURS',

      // Event Orders - Content
      'viewing': 'Viewing',
      'final_price': 'Final Price',
      'event_at': 'Event on @day, @date from @start to @end',
      'note_label': 'Note',
      'at_location': 'At @address',

      // Asset Orders - Tabs
      'all_orders': 'All',
      'pending_status': 'Pending',
      'paid_status': 'Paid',
      'cancelled_status': 'Cancelled',

      // Asset Orders - Content
      'purchased_designs': 'Purchased Designs',
      'category_label': 'Category',
      'load_more_orders': 'Load More Orders',

      // Empty States
      'no_current_orders': 'No current orders',
      'no_history_orders': 'No order history',
      'no_asset_orders': 'No purchased designs yet',
      'no_pending_asset_orders': 'No pending orders',
      'no_paid_asset_orders': 'No paid orders',
      'no_cancelled_asset_orders': 'No cancelled orders',

      //partner show
      'my_shows': 'My Shows',

      'news': 'News',
      'upcomings': 'Upcomings',
      'histories': 'Histories',

      'detail_info': 'Detail info',

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

      'currency': 'VNĐ',

      'click_to_upload': 'Click to upload',
      'upload_description': 'PNG, JPG, JPEG, WEBP (Maximum 5MB)',

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
      'status': 'Status',
      'time': 'Time',
      'location': 'Location',
      'event': 'Event',
      'start_time': 'Start Time',
      'end_time': 'End Time',
      'note': 'Note',
      'price': 'Price',
      'your_price': 'Your Price',

      'total_price': 'Total Price',

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

      'upload_arrived_photo': 'Upload arrived photo',
      'upload_arrived_photo_desc':
          'Upload a photo to confirm you have arrived at the location.',

      'confirm_complete': 'Confirm completion',
      'confirm_complete_message':
          'Are you sure you want to mark this bill as completed?',

      'complete_bill_success': 'The bill has been completed!',
      'insufficient_balance': 'Insufficient balance to complete the bill!',

      ///New Show
      'accept_new_show': ' Accept New Show',
      'accept_new_show_desc': 'View new show in real time.',

      'apply_for_show': 'Apply for Show',
      'price_quote': 'Show price Quote',
      'price_quote_for_show': 'Price Quote for Show #@code',
      'input_price_quote': 'Input your price',

      'invalid_price': 'Please enter a valid price (minimum @min)',
      'accepted_show': 'You have accepted show #@code',
      'failed_to_accept_show': 'Failed to accept show, please try again',

      'needs': 'Needs',

      //messages
      'no_messages': 'No messages yet',
      'no_further_messages': 'No further messages',

      'bill_info': 'Bill information',

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

      'forbidden': 'Forbidden',
      'not_found': 'Not Found',
      'invalid_request': 'Invalid Request',
      'load_data_failed': 'Failed to load data',

      //times
      'just_now': 'just now',
      'minute_ago': '@count minute ago',
      'minutes_ago': '@count minutes ago',
      'hour_ago': '@count hour ago',
      'hours_ago': '@count hours ago',
      'day_ago': '@count day ago',
      'days_ago': '@count days ago',
      'month_ago': '@count month ago',
      'months_ago': '@count months ago',
      'year_ago': '@count year ago',
      'years_ago': '@count years ago',

      //buttons
      'next': 'Next',
      'register': 'Register',
      'login': 'Login',
      'start_now': 'Start Now',
      'start': 'Start',
      'previous': 'Previous',
      'skip': 'Skip',
      'cancel': 'Cancel',
      'done': 'Done',
      'confirm': 'Confirm',
      'take_photo': 'Take Photo',
      'complete': 'Complete',

      //dev
      'in_dev': 'Feature in development',
    },
  };
}
