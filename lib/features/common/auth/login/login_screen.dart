import 'package:sukientotapp/features/common/auth/login/login_controller.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 100, height: 100),
            Text(
              'welcome_back'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                FTextFormField(
                  enabled: true,
                  label: Text('username'.tr),
                  hint: 'username_hint'.tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null ? null : 'username_invalid'.tr,
                  onSaved: (value) => controller.username.value = value ?? '',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                FTextFormField.password(
                  label: Text('password'.tr),
                  hint: 'password_hint'.tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => 8 <= (value?.length ?? 0) ? null : 'password_invalid'.tr,
                  onSaved: (value) => controller.password.value = value ?? '',
                ),
              ],
            ),
            const SizedBox(height: 30),

            Obx(
              () => FButton(
                onPress: controller.isLoading.value ? null : controller.login,
                child: controller.isLoading.value
                    ? Text('logging_loading'.tr)
                    : Text('login'.tr),
              ),
            ),
            const SizedBox(height: 20),
            FButton(
              onPress: null,
              prefix: FaIcon(FontAwesomeIcons.google),
              child: controller.isLoading.value
                  ? Text('logging_loading'.tr)
                  : Text('google_login'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
