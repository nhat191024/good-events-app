import 'package:sukientotapp/core/utils/app_exceptions.dart';
import 'package:sukientotapp/core/utils/app_validators.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/common/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordRepository _repository;
  ChangePasswordController(this._repository);

  final isLoading = false.obs;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) return 'password_invalid'.tr;
    return null;
  }

  String? validateNewPassword(String? value) =>
      AppValidators.validatePassword(value);

  String? validateConfirmPassword(String? value) {
    if (value != newPasswordController.text) return 'password_mismatch_error'.tr;
    return null;
  }

  Future<void> submitChangePassword() async {
    if (formKey.currentState?.validate() != true) return;
    try {
      isLoading.value = true;
      await _repository.updatePassword(
        currentPassword: currentPasswordController.text.trim(),
        password: newPasswordController.text.trim(),
        passwordConfirmation: confirmPasswordController.text.trim(),
      );
      AppSnackbar.showSuccess(message: 'password_change_success'.tr);
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();
    } catch (e) {
      logger.e('[ChangePasswordController] [submitChangePassword] error: $e');
      if (e is PasswordValidationException) {
        final message = e.codes.map((code) => code.tr).join('\n');
        AppSnackbar.showError(message: message);
      } else {
        final message = e.toString().replaceFirst('Exception: ', '');
        AppSnackbar.showError(message: message);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
