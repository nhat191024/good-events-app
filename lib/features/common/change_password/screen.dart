import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          FScaffold(
            childPad: false,
            resizeToAvoidBottomInset: true,
            header: Container(
              padding: EdgeInsets.only(
                top: context.statusBarHeight + 8,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.lightForeground,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'change_password'.tr,
                    style: Get.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FTextFormField.password(
                      control: FTextFieldControl.managed(
                        controller: controller.currentPasswordController,
                      ),
                      label: Text('current_password'.tr),
                      hint: 'current_password_hint'.tr,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.validateCurrentPassword,
                    ),
                    const SizedBox(height: 20),
                    FTextFormField.password(
                      control: FTextFieldControl.managed(
                        controller: controller.newPasswordController,
                      ),
                      label: Text('new_password'.tr),
                      hint: 'new_password_hint'.tr,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.validateNewPassword,
                    ),
                    const SizedBox(height: 20),
                    FTextFormField.password(
                      control: FTextFieldControl.managed(
                        controller: controller.confirmPasswordController,
                      ),
                      label: Text('confirm_new_password'.tr),
                      hint: 'confirm_new_password_hint'.tr,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.validateConfirmPassword,
                    ),
                    const SizedBox(height: 40),
                    FButton(
                      onPress: controller.isLoading.value
                          ? null
                          : controller.submitChangePassword,
                      child: Text('save'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.fTheme.colors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
