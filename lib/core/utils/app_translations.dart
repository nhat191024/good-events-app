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
      'name_required': 'Vui lòng nhập họ và tên.',
      'email_address': 'Địa chỉ email',
      'email_hint': 'email@vídụ.com',
      'email_required': 'Vui lòng nhập địa chỉ email.',
      'phone_number': 'Số điện thoại',
      'phone_hint': '0987654321',
      'identity_card_number': 'Số CCCD',
      'cccd_hint': 'Nhập số CCCD của bạn',
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
      'notifications': 'Thông báo',
      'no_notifications': 'Chưa có thông báo nào',
      'conversations': 'Trò chuyện',
      'orders': 'Đơn hàng',

      //search hints
      'search_hint_1': 'Bạn đang tìm dịch vụ gì?',
      'search_hint_2': 'Bạn cần gì cho sự kiện của mình?',
      'search_hint_3': 'Đang có nhu cầu tổ chức sự kiện?',

      //guest
      'dont_have_account': 'Không có tài khoản sự kiện tốt?',
      'partner_register_now': 'Đăng ký để bắt đầu làm việc ngay hôm nay!',
      'customer_register_now': 'Đăng ký để trải nghiệm dịch vụ ngay hôm nay!',
      'register_now': 'Đăng ký ngay',
      'become_partner': 'Trở thành đối tác',
      'no_blogs': 'Chưa có bài viết nào',

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
      'search_orders': 'Tìm kiếm đơn hàng: PB0123, Chú hề, ghi chú...',
      'sort_by': 'Sắp xếp theo',
      'sort_upcoming': 'Đơn sắp tới',
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
      'history_orders_label': 'Lịch sử đơn',
      'history_yours': 'LỊCH SỬ CỦA BẠN',
      'sort_newest': 'Theo ngày đặt',
      'sort_oldest': 'Cũ hơn',
      'sort_latest_activity': 'Mới cập nhật',
      'partner_received': 'Nhận đơn:',
      'unrated': 'Chưa đánh giá',
      'created_at_label': 'Tạo lúc:',

      // Client Order Detail
      'order_details_title': 'Chi tiết đơn hàng',
      'you_are_viewing_history':
          'Bạn đang xem lịch sử, đối tác đã từng được bạn chốt đơn sẽ hiển thị ở đây. Bạn cũng có thể đánh giá trải nghiệm của mình bên dưới',
      'please_wait_a_moment':
          'Vui lòng đợi một lúc, chúng tôi đang gửi thông báo đến cho các đối tác gần đó và sẽ tải lại trang cho bạn',
      'proposed_partner_price': 'Giá đối tác đề xuất',
      'completion_rate': 'Tỷ lệ hoàn thành',
      'profile': 'Hồ sơ',
      'choose_partner': 'Chọn đối tác',
      'cancel_order': 'Hủy đơn hàng',
      'applicants_list': 'Danh sách đăng ký',
      'chosen': 'Đã chọn',
      'discounted': 'Đã giảm',
      'rate_now': 'Đánh giá',
      'rate_order': 'Đánh giá đơn hàng',
      'rate_partner': 'Đánh giá đối tác (1-5 sao)',
      'review_service': 'Nhận xét về dịch vụ',
      'share_experience': 'chia sẻ trải nghiệm của bạn...',
      'submit_review': 'Gửi đánh giá',
      'evaluate': 'Đánh giá',
      'arrival_photo_banner': 'Ảnh đã đến nơi',
      'click_to_view_photo': 'Bấm để xem ảnh',
      'detailed_rental_info': 'Thông tin thuê chi tiết',
      'detailed_history_info': 'Chi tiết lịch sử đơn',
      'event_date': 'Ngày sự kiện',
      'event_type': 'Loại sụ kiện',
      'special_note': 'Ghi chú đặc biệt',
      'none': 'Không',
      'order_creation_time': 'Thời gian tạo đơn',
      'chosen_partner': 'Đối tác đã chốt',
      'sealing_price': 'Giá niêm phong',
      'apply_voucher_code':
          'Mã giảm giá (Áp dụng vào giá chốt của ứng viên bạn chọn)',
      'apply_code': 'Áp dụng mã',
      'check_and_save_code': 'Kiểm tra & Lưu mã',
      'voucher_placeholder': 'VD: N1993+1...',
      'applied_code': 'Mã áp dụng',
      'not_applicable': 'Không áp dụng',
      'voucher_validation_failed': 'Kiểm tra mã thất bại.',
      'please_enter_voucher_code': 'Vui lòng nhập mã giảm giá.',
      'discount_from_voucher': 'Giá đã giảm từ mã giảm giá: ',
      'review_submitted_success': 'Gửi đánh giá thành công!',
      'please_select_rating': 'Vui lòng chọn số sao đánh giá.',
      'voucher_check_result': 'Kết quả kiểm tra mã',
      'available': 'Khả dụng',
      'valid_voucher': 'Mã giảm giá hợp lệ',
      'discount_amount': 'Mức giảm',
      'on_final_price': 'trên giá chốt',
      'maximum': 'Tối đa',
      'min_order_condition': 'Điều kiện đơn tối thiểu',
      'voucher_apply_hint': 'Mã sẽ áp dụng khi bạn chốt giá với đối tác.',
      'validity_period': 'Thời gian hiệu lực',
      'starts_at': 'Bắt đầu',
      'expires_at_label': 'Hết hạn',
      'usage_count': 'Lượt sử dụng',
      'unlimited_usage': 'Không giới hạn lượt dùng',
      'remaining_usage': 'Còn @count lượt',
      'keep_code_hint': 'Giữ nguyên mã khi bấm "Chọn đối tác".',
      'voucher_saved_temp':
          'Mã đã được lưu tạm thời, chỉ cần giữ nguyên trường mã khi bấm "Chọn đối tác" để áp dụng.',
      'close': 'Đóng',
      'save_code': 'Lưu mã',
      'chat_now': 'Chat ngay',
      'back_to_list': 'Quay lại danh sách',
      'partner_not_found': 'Hiện chưa có đối tác',

      // Confirm Choose Partner Dialog
      'confirm_choose_partner_title': 'Bạn có muốn chọn đối tác (@name)?',
      'confirm_choose_partner_desc':
          'Xác nhận chốt đơn sẽ mở khóa chat với đối tác và không thể chọn lại đối tác khác cho đơn này.',
      'partner_proposed_price_label': 'Đối tác trả giá: ',
      'accept_price_question': 'Bạn có chấp nhận mức giá này không?',
      'confirm_no_btn': 'Ko, chưa chốt',
      'confirm_yes_btn': 'Chốt đơn luôn!',
      'choose_partner_success': 'Chốt đơn thành công!',
      'choose_partner_failed': 'Chốt đơn thất bại.',

      // Cancel Order Dialog
      'confirm_cancel_order_title': 'Bạn có chắc chắn muốn hủy đơn không?',
      'confirm_cancel_order_desc':
          'Lượt hủy này có thể sẽ tăng tỉ lệ hủy đơn của tài khoản của bạn. Bạn sẽ phải đợi xác nhận nếu đã lỡ chốt đơn với một đối tác bất kỳ. Trong trường hợp đó, hãy chat với đối tác trước khi thực hiện hủy nhé!',
      'cancel_order_no_btn': 'Ko hủy, tôi lỡ tay',
      'cancel_order_yes_btn': 'Hủy đơn ngay',
      'cancel_success': 'Hủy đơn thành công!',
      'cancel_failed': 'Hủy đơn thất bại, vui lòng thử lại.',

      'network_error': 'Lỗi mạng, vui lòng kiểm tra lại.',
      'fetch_failed': 'Không thể tải dữ liệu.',

      // Asset Orders - Tabs
      'all_orders': 'Tất cả',
      'pending_status': 'Chờ xử lý',
      'paid_status': 'Đã thanh toán',
      'cancelled_status': 'Đã hủy',

      // Asset Orders - Content
      'purchased_designs': 'File - Tài liệu đã mua',
      'category_label': 'Danh mục',
      'load_more_orders': 'Xem thêm đơn hàng',

      // Asset Order Detail
      'report_bill_title': 'Báo cáo sự cố',
      'report_title_label': 'Tiêu đề',
      'report_title_hint': 'Nhập tiêu đề báo cáo',
      'report_desc_label': 'Mô tả chi tiết',
      'report_desc_hint': 'Trình bày rõ vấn đề bạn gặp phải...',
      'submit_report': 'Gửi báo cáo',
      'report_success_message': 'Gửi báo cáo sự cố thành công!',
      'report_failed': 'Gửi báo cáo thất bại, vui lòng thử lại.',

      // Asset Order Detail
      'asset_order_detail_title': 'Chi tiết đơn thiết kế',
      'asset_order_details': 'Thông tin đơn hàng',
      'order_id': 'Mã đơn',
      'updated_at_label': 'Cập nhật lúc',
      'payment_method': 'Phương thức thanh toán',
      'design_price': 'Giá thiết kế',
      'tax': 'Thuế',
      'final_total': 'Thành tiền',
      'download_zip': 'Tải ZIP',
      'download': 'Tải xuống',
      'download_starting': 'Đang chuẩn bị tải xuống...',
      'repay': 'Thanh toán lại',

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
      'login_required': 'Bạn phải đăng nhập trước!',
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
      'unverified': 'Chưa xác minh',

      'currency': 'VND',

      'click_to_upload': 'Nhấn để tải ảnh lên',
      'upload_description': 'PNG, JPG, JPEG, WEBP (Tối đa 5MB)',

      'completed_orders': 'Đơn đã hoàn thành',
      'cancellation_rate': 'Tỷ lệ hủy',

      'front': 'Mặt trước',
      'back': 'Mặt sau',

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
      'current_password': 'Mật khẩu hiện tại',
      'current_password_hint': 'Nhập mật khẩu hiện tại',
      'new_password': 'Mật khẩu mới',
      'new_password_hint': 'Nhập mật khẩu mới',
      'confirm_new_password': 'Xác nhận mật khẩu mới',
      'confirm_new_password_hint': 'Nhập lại mật khẩu mới',
      'password_change_success': 'Đổi mật khẩu thành công',
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

      'stage_name': 'Nghệ danh',
      'stage_name_hint': 'Nhập nghệ danh của bạn',

      'bio': 'Tiểu sử',
      'bio_hint': 'Hãy kể cho chúng tôi về bạn và dịch vụ của bạn...',

      'id_card': 'ID Card',

      'province': 'Thành phố',
      'district': 'Phường',
      'select_province_first': 'Vui lòng chọn thành phố trước',
      'select_province': 'Chọn thành phố',
      'ward': 'Phường',
      'select_district': 'Chọn phường xã',

      'selfie_image': 'Ảnh selfie',
      'identity_card_image_front': 'Ảnh CCCD mặt trước',
      'identity_card_image_back': 'Ảnh CCCD mặt sau',

      'profile_updated': 'Hồ sơ đã được cập nhật!',

      ///Statuses
      'success': 'Thành công',
      'failed': 'Thất bại',
      'error': 'Lỗi',
      'info': 'Thông tin',

      'forbidden': 'Không có quyền',
      'not_found': 'Không tìm thấy',
      'invalid_request': 'Yêu cầu không hợp lệ',
      'load_data_failed': 'Không thể tải dữ liệu',
      'update_failed': 'Cập nhật thất bại',

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
      'edit_profile': 'Chỉnh sửa hồ sơ',
      'save': 'Lưu',

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
      'name_required': 'Please enter your full name.',
      'email_address': 'Email Address',
      'email_hint': 'email@example.com',
      'email_required': 'Please enter your email address.',
      'phone_number': 'Phone Number',
      'phone_hint': '0987654321',
      'identity_card_number': 'Identity Card Number',
      'cccd_hint': 'Enter your ID card number',
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
      'notifications': 'Notifications',
      'no_notifications': 'No notifications',
      'conversations': 'Conversations',
      'orders': 'Orders',

      //search hints
      'search_hint_1': 'What service are you looking for?',
      'search_hint_2': 'What do you need for your event?',
      'search_hint_3': 'Are you planning an event?',

      //guest
      'dont_have_account': "Don't have a Sự kiện tốt account?",
      'partner_register_now': 'Register to start working today!',
      'customer_register_now': 'Register to experience the service today!',
      'register_now': 'Register Now',
      'become_partner': 'Become a Partner',
      'no_blogs': 'No blogs available',

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
      'applicants_list': 'Applicants List',
      'chosen': 'Chosen',
      'discounted': 'Discounted',
      'rate_now': 'Rate now',
      'rate_order': 'Rate Order',
      'rate_partner': 'Rate Partner (1-5 stars)',
      'review_service': 'Service Review',
      'share_experience': 'share your experience...',
      'submit_review': 'Submit Review',

      // Event Orders - Status
      'status_pending': 'Pending',
      'status_confirmed': 'Confirmed',
      'status_in_job': 'At Location',
      'status_completed': 'Completed',
      'status_cancelled': 'Cancelled',

      // Event Orders - Filters
      'search_orders': 'Search orders...',
      'sort_by': 'Sort by',
      'sort_upcoming': 'Upcoming Orders',
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
      'history_orders_label': 'History Orders',
      'history_yours': 'HISTORY OF YOURS',
      'sort_newest': 'By order date',
      'sort_oldest': 'Oldest',
      'sort_latest_activity': 'Latest activities',
      'partner_received': 'Partner:',
      'unrated': 'Not rated',
      'created_at_label': 'Created at:',

      // Client Order Detail
      'order_details_title': 'Order Details',
      'you_are_viewing_history':
          'You are viewing history. The partner you finalized will be shown here. You can also evaluate your experience below.',
      'please_wait_a_moment':
          'Please wait a moment, we are sending notifications to nearby partners and will reload the page for you.',
      'proposed_partner_price': 'Partner Proposed Price',
      'completion_rate': 'Completion Rate',
      'profile': 'Profile',
      'choose_partner': 'Choose Partner',
      'evaluate': 'Evaluate',
      'arrival_photo_banner': 'Arrival Photo',
      'click_to_view_photo': 'Tap to view photo',
      'detailed_rental_info': 'Detailed Rental Info',
      'detailed_history_info': 'Detailed History Info',
      'event_date': 'Event Date',
      'event_type': 'Event Type',
      'special_note': 'Special Note',
      'none': 'None',
      'order_creation_time': 'Order Creation Time',
      'chosen_partner': 'Chosen Partner',
      'sealing_price': 'Sealing Price',
      'apply_voucher_code':
          'Voucher Code (Applied to the final price of the chosen applicant)',
      'apply_code': 'Apply Code',
      'check_and_save_code': 'Check & Save Code',
      'voucher_placeholder': 'EX: N1993+1...',
      'applied_code': 'Applied Code',
      'not_applicable': 'Not Applicable',
      'voucher_validation_failed': 'Voucher validation failed.',
      'please_enter_voucher_code': 'Please enter a voucher code.',
      'discount_from_voucher': 'Price discounted from voucher: ',
      'review_submitted_success': 'Review submitted successfully!',
      'please_select_rating': 'Please select a rating.',
      'voucher_check_result': 'Voucher check result',
      'available': 'Available',
      'valid_voucher': 'Valid voucher',
      'discount_amount': 'Discount amount',
      'on_final_price': 'on final price',
      'maximum': 'Maximum',
      'min_order_condition': 'Minimum order condition',
      'voucher_apply_hint':
          'Voucher will apply when you finalize with a partner.',
      'validity_period': 'Validity period',
      'starts_at': 'Starts at',
      'expires_at_label': 'Expires at',
      'usage_count': 'Usage count',
      'unlimited_usage': 'Unlimited usage',
      'remaining_usage': '@count uses remaining',
      'keep_code_hint': 'Keep the code when tapping "Choose Partner".',
      'voucher_saved_temp':
          'Voucher saved temporarily. Keep the field as is when finalizing to apply.',
      'close': 'Close',
      'save_code': 'Save Code',
      'chat_now': 'Chat Now',
      'cancel_order': 'Cancel Order',
      'back_to_list': 'Back to List',
      'partner_not_found': 'Currently no partners found',

      // Confirm Choose Partner Dialog
      'confirm_choose_partner_title': 'Do you want to choose partner (@name)?',
      'confirm_choose_partner_desc':
          'Finalizing the order will unlock chat with the partner and you won\'t be able to choose another partner for this order.',
      'partner_proposed_price_label': 'Partner proposed price: ',
      'accept_price_question': 'Do you accept this price?',
      'confirm_no_btn': 'No, not yet',
      'confirm_yes_btn': 'Finalize now!',
      'choose_partner_success': 'Partner chosen successfully!',
      'choose_partner_failed': 'Failed to choose partner.',

      // Cancel Order Dialog
      'confirm_cancel_order_title':
          'Are you sure you want to cancel the order?',
      'confirm_cancel_order_desc':
          'This cancellation may increase your account\'s cancellation rate. You will need confirmation if you have already finalized with a partner. In that case, please chat with the partner before cancelling!',
      'cancel_order_no_btn': 'No, my mistake',
      'cancel_order_yes_btn': 'Cancel now',
      'cancel_success': 'Order cancelled successfully!',
      'cancel_failed': 'Failed to cancel order, please try again.',

      'network_error': 'Network error, please check again.',
      'fetch_failed': 'Failed to load data.',

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
      'login_required': 'You must login first!',
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
      'unverified': 'Unverified',

      'currency': 'VNĐ',

      'click_to_upload': 'Click to upload',
      'upload_description': 'PNG, JPG, JPEG, WEBP (Maximum 5MB)',

      'completed_orders': 'Completed Orders',
      'cancellation_rate': 'Cancelled rate',

      'front': 'Front',
      'back': 'Back',

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

      ///messages
      'no_messages': 'No messages yet',
      'no_further_messages': 'No further messages',

      'bill_info': 'Bill information',

      'conversation': 'Conversation',
      'type_a_message': 'Type a message...',

      ///account
      'general_setting': 'General Setting',
      'more_setting': 'More Setting',

      'my_profile': 'My Profile',
      'show_calendar': 'Show Calendar',
      'my_services': 'My Services',
      'revenue_statistics': 'Revenue Statistics',
      'change_password': 'Change Password',
      'current_password': 'Current Password',
      'current_password_hint': 'Enter current password',
      'new_password': 'New Password',
      'new_password_hint': 'Enter new password',
      'confirm_new_password': 'Confirm New Password',
      'confirm_new_password_hint': 'Re-enter new password',
      'password_change_success': 'Password changed successfully',
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

      'stage_name': 'Stage name',
      'stage_name_hint': 'Enter your stage name',

      'bio': 'Bio',
      'bio_hint': 'Tell us about yourself and your services...',

      'id_card': 'ID Card',

      'province': 'City',
      'district': 'District',
      'select_province_first': 'Please select city first',
      'select_province': 'Select City',
      'ward': 'Ward',
      'select_district': 'Select ward',

      'selfie_image': 'Selfie Image',
      'identity_card_image_front': 'Identity Card Image Front',
      'identity_card_image_back': 'Identity Card Image Back',

      'profile_updated': 'Profile has been updated!',

      ///Statuses
      'success': 'Success',
      'failed': 'Failed',
      'error': 'Error',
      'info': 'Information',

      'forbidden': 'Forbidden',
      'not_found': 'Not Found',
      'invalid_request': 'Invalid Request',
      'load_data_failed': 'Failed to load data',
      'update_failed': 'Update failed',

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

      ///buttons
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
      'edit_profile': 'Edit Profile',
      'save': 'Save',

      /// Asset Order Detail
      'asset_order_detail_title': 'Design Order Detail',
      'asset_order_details': 'Order Information',
      'order_id': 'Order ID',
      'updated_at_label': 'Updated',
      'payment_method': 'Payment Method',
      'design_price': 'Design Price',
      'tax': 'Tax',
      'final_total': 'Final Total',
      'download_zip': 'Download ZIP',
      'download': 'Download',
      'download_starting': 'Preparing download...',
      'repay': 'Repay',

      // Report bottom sheet
      'report_bill_title': 'Report Issue',
      'report_title_label': 'Title',
      'report_title_hint': 'Enter report title',
      'report_desc_label': 'Description',
      'report_desc_hint': 'Describe the issue clearly...',
      'submit_report': 'Submit Report',
      'report_success_message': 'Report submitted successfully!',
      'report_failed': 'Failed to submit report. Please try again.',

      //dev
      'in_dev': 'Feature in development',
    },
  };
}
