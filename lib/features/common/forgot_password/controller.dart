import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/common/forgot_password_repository.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository;

  ForgotPasswordController(this._repository);

  final formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final success = await _repository.forgotPassword(inputController.text.trim());
      if (success) {
        AppSnackbar.showSuccess(message: 'forgot_password_success_message'.tr);
        Get.back();
      } else {
        AppSnackbar.showError(message: 'forgot_password_send_failed'.tr);
      }
    } catch (e) {
      AppSnackbar.showError(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}