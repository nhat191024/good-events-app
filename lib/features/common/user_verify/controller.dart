import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/home/controller.dart';

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

  // check client or partner
  bool get isClientUser => Get.find<GuestHomeController>().userType.value;

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

  Future<void> goToOtpStep() async {
    // trigger the initial OTP send BEFORE switching to step 2
    await _sendOtp();
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

    isLoading.value = true;
    try {
      // TODO: call the verify OTP API
      //   await _authRepository.verifyOtp(
      //     method: selectedMethod.value == VerifyMethod.email ? 'email' : 'phone',
      //     otp: otpController.text.trim(),
      //   );

      Get.snackbar('success'.tr, 'verify_success'.tr);
      Get.offAllNamed(isClientUser ? Routes.clientHome : Routes.partnerHome);
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    await _sendOtp();
    Get.snackbar('success'.tr, 'otp_resent'.tr);
  }

  /// decides which API to call based on [selectedMethod].
  /// call this when entering step 2 (goToOtpStep) or resending (resendOtp).
  Future<void> _sendOtp() async {
    isLoading.value = true;
    try {
      if (selectedMethod.value == VerifyMethod.email) {
        // TODO: call send-OTP-via-email API
        //   await _authRepository.sendOtpEmail();
        Get.snackbar('success'.tr, 'otp_sent'.tr);
        logger.d('[UserVerifyController] Sending OTP via EMAIL...');
      } else {
        // TODO: call send-OTP-via-Zalo/SMS API
        //   await _authRepository.sendOtpPhone();
        Get.snackbar('success'.tr, 'otp_sent'.tr);
        logger.d('[UserVerifyController] Sending OTP via Zalo/SMS...');
      }
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
      rethrow; // prevent moving to step 2 if the send failed
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    // TODO: clear auth storage and navigate to login
    Get.offAllNamed(Routes.loginScreen);
  }
}
