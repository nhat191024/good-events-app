import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/bottom_navigation/controller.dart';
import 'widgets/booking_loading_dialog.dart';

class ClientBookingController extends GetxController {
  static const String customEventTypeKey = 'event_type_custom';
  static const int totalStages = 3;

  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;
  final RxInt currentStage = 0.obs;

  final RxList<String> eventTypes = <String>[].obs;
  final RxList<String> provinces = <String>[].obs;
  final RxList<String> wards = <String>[].obs;

  final RxString selectedStartTime = ''.obs;
  final RxString selectedEndTime = ''.obs;
  final RxString selectedEventDate = ''.obs;
  final RxString selectedEventType = ''.obs;
  final RxString selectedProvince = ''.obs;
  final RxString selectedWard = ''.obs;

  final TextEditingController customEventController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressDetailController = TextEditingController();

  final Map<String, List<String>> wardOptions = const {
    'Bắc Ninh': ['Phường Cảnh Thụy', 'Phường Đáp Cầu', 'Phường Vũ Ninh'],
    'Hà Nội': ['Quận Ba Đình', 'Quận Cầu Giấy', 'Quận Hai Bà Trưng'],
    'Hồ Chí Minh': ['Quận 1', 'Quận 3', 'Quận 7'],
  };

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  bool get shouldShowCustomEvent => selectedEventType.value == customEventTypeKey;
  bool get isFirstStage => currentStage.value == 0;
  bool get isLastStage => currentStage.value == totalStages - 1;

  Future<void> loadMockData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    eventTypes.assignAll([
      customEventTypeKey,
      'event_type_wedding',
      'event_type_conference',
      'event_type_birthday',
    ]);

    provinces.assignAll(wardOptions.keys.toList());

    selectedStartTime.value = '01:00';
    selectedEndTime.value = '03:00';
    selectedEventType.value = eventTypes.isNotEmpty ? eventTypes.first : '';
    selectedProvince.value = provinces.isNotEmpty ? provinces.first : '';
    _syncWards(selectedProvince.value);

    isLoading.value = false;
  }

  void nextStage() {
    if (currentStage.value < totalStages - 1) {
      currentStage.value += 1;
    }
  }

  void previousStage() {
    if (currentStage.value > 0) {
      currentStage.value -= 1;
    }
  }

  void startOver() {
    currentStage.value = 0;
  }

  void selectStartTime(String value) {
    selectedStartTime.value = value;
  }

  void selectEndTime(String value) {
    selectedEndTime.value = value;
  }

  void selectEventDate(DateTime date) {
    selectedEventDate.value = DateFormat('dd/MM/yyyy').format(date);
  }

  void selectEventType(String value) {
    selectedEventType.value = value;
    if (value != customEventTypeKey) {
      customEventController.clear();
    }
  }

  void selectProvince(String value) {
    selectedProvince.value = value;
    _syncWards(value);
  }

  void selectWard(String value) {
    selectedWard.value = value;
  }

  void _syncWards(String province) {
    wards.assignAll(wardOptions[province] ?? []);
    selectedWard.value = wards.isNotEmpty ? wards.first : '';
  }

  Future<void> submitBooking() async {
    if (isSubmitting.value) return;
    isSubmitting.value = true;

    Get.dialog(
      const BookingLoadingDialog(),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.snackbar('success'.tr, 'booking_success'.tr);

    Get.offAllNamed(Routes.clientHome);
    Get.find<ClientBottomNavigationController>().setIndex(1);

    isSubmitting.value = false;
  }

  @override
  void onClose() {
    customEventController.dispose();
    noteController.dispose();
    addressDetailController.dispose();
    super.onClose();
  }
}
