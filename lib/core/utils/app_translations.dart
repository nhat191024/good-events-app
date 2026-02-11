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
      'booking_note_placeholder': 'VD: Cần người mặc đồng phục có tông màu vàng',
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
      'booking_stage_time_subtitle': 'Chọn giờ bắt đầu, kết thúc và ngày tổ chức.',
      'booking_stage_event_title': 'Nội dung sự kiện',
      'booking_stage_event_subtitle': 'Cho biết nội dung hoặc ghi chú cần thiết.',
      'booking_stage_location_title': 'Địa điểm tổ chức',
      'booking_stage_location_subtitle': 'Chọn khu vực và nhập địa chỉ chi tiết.',
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
      'cancel': 'Hủy',
      'done': 'Xong',

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
      'booking_event_custom_placeholder': "e.g., Visit the President's Mausoleum",
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
      'booking_stage_event_subtitle': 'Describe the event and add notes if needed.',
      'booking_stage_location_title': 'Select location',
      'booking_stage_location_subtitle': 'Choose area and enter detailed address.',
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
      'cancel': 'Cancel',
      'done': 'Done',

      //dev
      'in_dev': 'Feature in development',
    },
  };
}
