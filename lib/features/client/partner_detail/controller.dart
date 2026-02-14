import 'package:sukientotapp/core/utils/import/global.dart';

class PartnerDetailController extends GetxController {
  final RxString partnerId = ''.obs;
  final RxString partnerName = ''.obs;
  final RxString partnerImage = ''.obs;

  // Dummy data for UI
  final RxString category = 'SỰ KIỆN'.obs;
  final RxString subCategory = 'CHÚ HỀ'.obs;
  final RxString serviceType = 'Chú hề hoạt náo'.obs;
  final RxString priceRange = '500.000 đ - 2.000.000 đ'.obs;
  final RxString updateTime = '3 tuần trước'.obs;

  /// note: don't change the 'format' of this description
  /// it would cause the actual content to change
  /// don't worry, this will be removed soon
  final RxString description =
      '''
🤡🎉 CHÚ HỀ HOẠT NÁO – NGƯỜI TRUYỀN NĂNG LƯỢNG & TIẾNG CƯỜI CHO MỌI SỰ KIỆN 🎉🤡

Chú Hề Hoạt Náo là nhân vật trung tâm giúp bầu không khí sự kiện trở nên vui nhộn và bùng nổ năng lượng. Với giọng nói dí dỏm, phong cách biểu diễn thân thiện và ngoại hình dễ thương với bộ trang phục rực rỡ, chú hề luôn thu hút mọi ánh nhìn ngay từ những giây đầu tiên.

Chú không chỉ mang đến những tiếng cười giòn giã, mà còn biết cách dẫn dắt các trò chơi, kết nối mọi người và giúp cho các bé tự tin tham gia hoạt động. Mỗi khoảnh khắc đều đầy ắp niềm vui và sự hứng khởi.

🎤 Điểm nổi bật của Chú Hề Hoạt Náo
• Giao lưu duyên dáng, tạo tiếng cười tự nhiên
• Đa dạng trò chơi phù hợp từng độ tuổi thiếu nhi
• Biết giữ nhịp chương trình – không khí luôn sôi động
• Tương tác chu đáo, luôn đảm bảo bé nào cũng có niềm vui
• Tạo điểm nhấn hình ảnh – chụp ảnh cùng khách cực đẹp

🎯 Thích hợp cho các chương trình:
✔ Sinh nhật – thôi nôi
✔ Khai trương – siêu thị – trung tâm thương mại
✔ Sự kiện trường học – trung thu – Noel
✔ Hội chợ – ngày hội gia đình – lễ hội doanh nghiệp

Chú Hề Hoạt Náo giúp bữa tiệc của bé trở thành một ngày thật đặc biệt và đáng nhớ – nơi tiếng cười được lan tỏa khắp không gian và mỗi đứa trẻ đều trở thành nhân vật chính của niềm vui.

🌟 Chọn Chú Hề Hoạt Náo – Chọn niềm vui và thành công cho sự kiện của bạn! 🌟
🎈 Hạnh phúc của trẻ nhỏ – Là đam mê của chúng tôi! 🎈
'''
          .obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments is Map<String, dynamic>) {
        final args = Get.arguments as Map<String, dynamic>;
        partnerId.value = args['id'] ?? '';
        partnerName.value = args['name'] ?? '';
        serviceType.value = args['name'] ?? '';
        partnerImage.value = args['image'] ?? '';
      }
    }

    fetchPartnerDetails();
  }

  void fetchPartnerDetails() async {
    isLoading.value = true;
    // fake API call
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }
}
