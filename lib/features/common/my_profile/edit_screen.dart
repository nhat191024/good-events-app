import 'dart:io';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/components/widget/upload_photo.dart';
import 'edit_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
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
              'edit_profile'.tr,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // --- Avatar section ---
            Obx(() {
              final localFile = controller.avatarFile.value;
              return GestureDetector(
                onTap: () => controller.pickImage('avatar'),
                child: Stack(
                  children: [
                    FAvatar(
                      image: localFile != null
                          ? FileImage(File(localFile.path)) as ImageProvider
                          : CachedNetworkImageProvider(
                              controller.initialProfile.avatarUrl,
                            ),
                      size: 100.0,
                      semanticsLabel: 'User avatar',
                      fallback: Text(
                        controller.initialProfile.name.isNotEmpty
                            ? controller.initialProfile.name[0].toUpperCase()
                            : '?',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: context.fTheme.colors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // --- Basic Info section ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.fTheme.colors.primaryForeground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FTextFormField(
                    control: FTextFieldControl.managed(
                      controller: controller.nameController,
                    ),
                    label: Text('full_name'.tr),
                    hint: 'name_hint'.tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'name_required'.tr,
                  ),
                  const SizedBox(height: 12),
                  FTextFormField(
                    control: FTextFieldControl.managed(
                      controller: controller.emailController,
                    ),
                    label: Text('email_address'.tr),
                    hint: 'email_hint'.tr,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'email_required'.tr,
                  ),
                  const SizedBox(height: 12),
                  // FTextFormField(
                  //   control: FTextFieldControl.managed(
                  //     controller: controller.countryCodeController,
                  //   ),
                  //   label: Text('country_code'.tr),
                  //   hint: '+84',
                  //   keyboardType: TextInputType.phone,
                  // ),
                  const SizedBox(height: 12),
                  FTextFormField(
                    control: FTextFieldControl.managed(
                      controller: controller.phoneController,
                    ),
                    label: Text('phone_number'.tr),
                    hint: 'phone_hint'.tr,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildBioField(context),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- Partner-only section ---
            Obx(
              () => controller.role.value == 'partner'
                  ? _buildPartnerSection(context)
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 24),

            // --- Save button ---
            Obx(
              () => CustomButtonPlus(
                onTap: controller.isUpdating.value
                    ? () {}
                    : controller.updateProfile,
                isDisabled: controller.isUpdating.value,
                isLoading: controller.isUpdating.value,
                width: double.infinity,
                btnText: 'save'.tr,
                textSize: 14,
                fontWeight: FontWeight.w600,
                height: 46,
                borderRadius: 8,
                borderColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBioField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'bio'.tr,
          style: context.typography.xs.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.fTheme.colors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: TextField(
              controller: controller.bioController,
              maxLines: 4,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'bio_hint'.tr,
                contentPadding: const EdgeInsets.all(12),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPartnerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.primaryForeground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FTextFormField(
            control: FTextFieldControl.managed(
              controller: controller.partnerNameController,
            ),
            label: Text('stage_name'.tr),
            hint: 'stage_name_hint'.tr,
          ),
          const SizedBox(height: 12),
          FTextFormField(
            control: FTextFieldControl.managed(
              controller: controller.identityCardController,
            ),
            label: Text('identity_card_number'.tr),
            hint: 'cccd_hint'.tr,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),

          // --- Location dropdowns ---
          _buildLocationSection(context),

          const SizedBox(height: 16),

          // --- Selfie photo ---
          Text(
            'selfie_image'.tr,
            style: context.typography.xs.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          UploadPhoto(
            onImagePicked: (file) => controller.selfieFile.value = file,
            onImageRemoved: () => controller.selfieFile.value = null,
          ),

          const SizedBox(height: 12),

          // --- Front card photo ---
          Text(
            'identity_card_image_front'.tr,
            style: context.typography.xs.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          UploadPhoto(
            onImagePicked: (file) => controller.frontCardFile.value = file,
            onImageRemoved: () => controller.frontCardFile.value = null,
          ),

          const SizedBox(height: 12),

          // --- Back card photo ---
          Text(
            'identity_card_image_back'.tr,
            style: context.typography.xs.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          UploadPhoto(
            onImagePicked: (file) => controller.backCardFile.value = file,
            onImageRemoved: () => controller.backCardFile.value = null,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Obx(() {
      final isLoadingProvinces = controller.provinces.isEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Province dropdown
          Text(
            'province'.tr,
            style:
                context.typography.xs.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 6),
          Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.fTheme.colors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoadingProvinces
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: controller.selectedProvince.value?.id,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              'select_province'.tr,
                              style: context.typography.sm.copyWith(
                                color: context.fTheme.colors.mutedForeground,
                              ),
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          items: controller.provinces
                              .map(
                                (p) => DropdownMenuItem<int>(
                                  value: p.id,
                                  child: Text(
                                    p.name,
                                    style: context.typography.sm,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (int? value) {
                            if (value != null) {
                              controller.onProvinceChanged(
                                controller.provinces
                                    .firstWhere((p) => p.id == value),
                              );
                            }
                          },
                        ),
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Ward dropdown
          Text(
            'district'.tr,
            style:
                context.typography.xs.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 6),
          Material(
            color: Colors.transparent,
            child: Obx(() {
              final isLoadingWards = controller.isLoadingWards.value;
              final noProvinceSelected =
                  controller.selectedProvince.value == null;

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: noProvinceSelected
                        ? context.fTheme.colors.border.withAlpha(100)
                        : context.fTheme.colors.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: noProvinceSelected
                      ? context.fTheme.colors.muted.withAlpha(40)
                      : null,
                ),
                child: isLoadingWards
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    : DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: controller.selectedWard.value?.id,
                            disabledHint: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                'select_province_first'.tr,
                                style: context.typography.sm.copyWith(
                                  color: context.fTheme.colors.mutedForeground,
                                ),
                              ),
                            ),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                'select_district'.tr,
                                style: context.typography.sm.copyWith(
                                  color: context.fTheme.colors.mutedForeground,
                                ),
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: context.fTheme.colors.mutedForeground,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            items: controller.wards
                                .map(
                                  (w) => DropdownMenuItem<int>(
                                    value: w.id,
                                    child: Text(
                                      w.name,
                                      style: context.typography.sm,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: noProvinceSelected
                                ? null
                                : (int? value) {
                                    if (value != null) {
                                      controller.selectedWard.value =
                                          controller.wards.firstWhere(
                                        (w) => w.id == value,
                                      );
                                    }
                                  },
                          ),
                        ),
                      ),
              );
            }),
          ),
        ],
      );
    });
  }
}
