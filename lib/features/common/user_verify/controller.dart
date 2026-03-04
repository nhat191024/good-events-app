import 'package:sukientotapp/core/utils/import/global.dart';

enum VerifyMethod { email, zalo }

class UserVerifyController extends GetxController {
  /// 1: method selection
  /// 2: OTP
  final step = 1.obs;

  final selectedMethod = Rx<VerifyMethod>(VerifyMethod.zalo);
  final otpController = TextEditingController();

  /// hide a small part of the info
  late final String maskedEmail;
  late final String maskedPhone;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    maskedEmail = args?['masked_email'] ?? '**@***.com';
    maskedPhone = args?['masked_phone'] ?? '0**...***';
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void selectMethod(VerifyMethod method) {
    selectedMethod.value = method;
  }

  void goToOtpStep() {
    step.value = 2;
  }

  void goBackToMethodStep() {
    step.value = 1;
    otpController.clear();
  }

  Future<void> verify() async {
    if (otpController.text.trim().length != 6) {
      Get.snackbar('error'.tr, 'otp_invalid'.tr);
      return;
    }
    // TODO: implement real OTP verification API call
    Get.snackbar('success'.tr, 'verify_success'.tr);
  }

  Future<void> resendOtp() async {
    // TODO: implement resend OTP API call
    Get.snackbar('success'.tr, 'otp_resent'.tr);
  }

  void logout() {
    // TODO: clear auth storage and navigate to login
    Get.offAllNamed(Routes.loginScreen);
  }
}
