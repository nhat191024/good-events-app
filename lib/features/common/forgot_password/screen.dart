import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text('forgot_password'.tr),
        prefixes: [FHeaderAction.back(onPress: Get.back)],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text('forgot_password_subtitle'.tr, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            FTextFormField(
              control: FTextFieldControl.managed(
                controller: controller.inputController,
              ),
              label: Text('email_or_phone'.tr),
              hint: 'email_or_phone_hint'.tr,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'email_or_phone_required'.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            Obx(
              () => FButton(
                onPress: controller.isLoading.value ? null : controller.submit,
                child: controller.isLoading.value
                    ? Text('sending'.tr)
                    : Text('send_reset_link'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
