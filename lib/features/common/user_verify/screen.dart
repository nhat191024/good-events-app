import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/user_verify/controller.dart';
import 'package:sukientotapp/features/common/user_verify/widgets/verify_header.dart';
import 'package:sukientotapp/features/common/user_verify/widgets/verify_method_card.dart';

class UserVerifyScreen extends GetView<UserVerifyController> {
  const UserVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Obx(
            () => controller.step.value == 1
                ? _MethodSelectionStep(controller: controller)
                : _OtpStep(controller: controller),
          ),
        ),
      ),
    );
  }
}

/// step 1 - choose method
class _MethodSelectionStep extends StatelessWidget {
  final UserVerifyController controller;
  const _MethodSelectionStep({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerifyHeader(
          title: 'verify_account_title'.tr,
          subtitle: 'verify_account_subtitle'.tr,
        ),
        const SizedBox(height: 32),

        // method options
        Obx(
          () => Column(
            children: [
              VerifyMethodCard(
                method: VerifyMethod.email,
                selected: controller.selectedMethod.value == VerifyMethod.email,
                icon: Icons.mail_outline_rounded,
                title: 'verify_via_email'.tr,
                subtitle: controller.maskedEmail,
                onTap: () => controller.selectMethod(VerifyMethod.email),
              ),
              const SizedBox(height: 12),
              VerifyMethodCard(
                method: VerifyMethod.zalo,
                selected: controller.selectedMethod.value == VerifyMethod.zalo,
                icon: Icons.message_rounded,
                title: 'verify_via_zalo'.tr,
                subtitle: 'verify_zalo_subtitle'.trParams({'phone': controller.maskedPhone}),
                onTap: () => controller.selectMethod(VerifyMethod.zalo),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        FButton(
          onPress: controller.goToOtpStep,
          child: Text('continue_btn'.tr),
        ),
        const SizedBox(height: 16),

        // logout link
        Center(
          child: TextButton.icon(
            onPressed: controller.logout,
            icon: const Icon(Icons.arrow_back, size: 14),
            label: Text(
              'logout'.tr,
              style: TextStyle(
                fontSize: 13,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// step 2 - enter otp
class _OtpStep extends StatelessWidget {
  final UserVerifyController controller;
  const _OtpStep({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final isEmail = controller.selectedMethod.value == VerifyMethod.email;
          return VerifyHeader(
            title: isEmail ? 'verify_email_title'.tr : 'verify_phone_title'.tr,
            subtitle: isEmail ? 'verify_email_otp_subtitle'.tr : 'verify_phone_otp_subtitle'.tr,
          );
        }),
        const SizedBox(height: 32),

        Center(
          child: Text(
            'enter_otp'.tr,
            style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 8),

        Material(
          color: Colors.transparent,
          child: TextField(
            controller: controller.otpController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 6,
            autofocus: true,
            autocorrect: false,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 12,
              fontFamily: 'monospace',
            ),
            decoration: InputDecoration(
              hintText: '------',
              hintStyle: TextStyle(
                fontSize: 24,
                letterSpacing: 10,
                color: context.fTheme.colors.mutedForeground,
              ),
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.fTheme.colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.fTheme.colors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
        const SizedBox(height: 24),

        Obx(
          () => FButton(
            onPress: controller.isLoading.value ? null : controller.verify,
            child: controller.isLoading.value ? Text('verifying'.tr) : Text('verify_btn'.tr),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: controller.resendOtp,
              icon: const Icon(Icons.send_rounded, size: 14),
              label: Text(
                'resend_otp'.tr,
                style: TextStyle(color: context.fTheme.colors.primary, fontSize: 13),
              ),
            ),
            TextButton(
              onPressed: controller.goBackToMethodStep,
              child: Text(
                'back_to_method'.tr,
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 32),

        Center(
          child: TextButton(
            onPressed: controller.logout,
            child: Text(
              'logout'.tr,
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.underline,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
