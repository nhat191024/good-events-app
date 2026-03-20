import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/auth/register/controller.dart';
import 'package:sukientotapp/features/common/auth/register/widgets/partner_location_selector.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 22),
        child: BackButton(),
      ),
      child: Form(
        key: controller.registerFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'create_account'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Name, Email, Phone
              const SizedBox(height: 8),
              FTextFormField(
                control: FTextFieldControl.managed(
                  controller: controller.nameController,
                ),
                label: Text('full_name'.tr),
                hint: 'name_hint'.tr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value?.isNotEmpty ?? false) ? null : 'name_invalid'.tr,
              ),
              const SizedBox(height: 16),

              FTextFormField(
                control: FTextFieldControl.managed(
                  controller: controller.emailController,
                ),
                label: Text('email_address'.tr),
                hint: 'email_hint'.tr,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value?.contains('@') ?? false)
                    ? null
                    : 'email_invalid'.tr, // TODO: Improve Email Regex Validator
              ),
              const SizedBox(height: 16),

              FTextFormField(
                control: FTextFieldControl.managed(
                  controller: controller.phoneController,
                ),
                label: Text('phone_number'.tr),
                hint: 'phone_hint'.tr,
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value?.isNotEmpty ?? false)
                    ? null
                    : 'phone_invalid'.tr, // TODO: Improve Phone Regex Validator
              ),
              const SizedBox(height: 16),

              if (!controller.isClientUser) ...[
                FTextFormField(
                  control: FTextFieldControl.managed(
                    controller: controller.cccdController,
                  ),
                  label: Text('identity_card_number'.tr),
                  hint: 'cccd_hint'.tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => (value?.isNotEmpty ?? false)
                      ? null
                      : 'cccd_invalid'.tr, // TODO: Improve CCCD Regex Validator
                ),
                const SizedBox(height: 16),
              ],

              FTextFormField.password(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                control: FTextFieldControl.managed(
                  controller: controller.passwordController,
                ),
                label: Text('password'.tr),
                hint: 'password_hint'.tr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => 8 <= (value?.length ?? 0) ? null : 'password_invalid'.tr,
              ),

              const SizedBox(height: 16),

              FTextFormField.password(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                autofocus: false,
                control: FTextFieldControl.managed(
                  controller: controller.confirmPasswordController,
                ),
                label: Text('password_confirmation'.tr),
                hint: 'password_confirmation_hint'.tr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != controller.passwordController.text) {
                    return 'password_mismatch_error'.tr;
                  }
                  return null;
                },
              ),

              if (!controller.isClientUser) ...[
                const SizedBox(height: 16),
                const PartnerLocationSelector(),
              ],
              const SizedBox(height: 30),

              Obx(
                () => FButton(
                  onPress: controller.isLoading.value ? null : controller.register,
                  child: controller.isLoading.value
                      ? Text('creating_account_loading'.tr)
                      : Text('create_account_btn'.tr),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
