import 'dart:io';

import 'package:flutter_quill/flutter_quill.dart';
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
      header: FHeader.nested(
        title: Text('edit_profile'.tr),
        prefixes: [FHeaderAction.back(onPress: () => Get.back())],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar Hero ────────────────────────────────────────
            _AvatarHero(controller: controller)
                .animate(delay: 100.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.02, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 20),

            // ── Basic Info ─────────────────────────────────────────
            _SectionLabel(label: 'basic_info'.tr)
                .animate(delay: 150.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.02, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 10),
            _FormCard(
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
                FTextFormField(
                  control: FTextFieldControl.managed(
                    controller: controller.phoneController,
                  ),
                  label: Text('phone_number'.tr),
                  hint: 'phone_hint'.tr,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _BioField(controller: controller),
              ],
            )
                .animate(delay: 200.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.02, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 20),

            // ── Partner Section ────────────────────────────────────
            Obx(
              () => controller.role.value == 'partner'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel(label: 'partner_info'.tr)
                            .animate(delay: 250.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(
                              begin: -0.02,
                              end: 0,
                              curve: Curves.easeOut,
                            ),
                        const SizedBox(height: 10),
                        _PartnerCard(controller: controller)
                            .animate(delay: 300.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(
                              begin: -0.02,
                              end: 0,
                              curve: Curves.easeOut,
                            ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),

            // ── Save Button ────────────────────────────────────────
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
                height: 44,
                borderRadius: 12,
                borderColor: Colors.transparent,
              ),
            )
                .animate(delay: 350.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}

// ─── Avatar Hero ──────────────────────────────────────────────────────────────

class _AvatarHero extends StatelessWidget {
  final EditProfileController controller;

  const _AvatarHero({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.fTheme.colors.primary,
            context.fTheme.colors.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
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
                    size: 90.0,
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
                        color: context.fTheme.colors.primaryForeground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.fTheme.colors.primary,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: context.fTheme.colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Text(
            controller.initialProfile.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.primaryForeground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'tap_to_change_avatar'.tr,
            style: TextStyle(
              fontSize: 11,
              color: context.fTheme.colors.primaryForeground.withValues(
                alpha: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: context.fTheme.colors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: context.fTheme.colors.foreground,
          ),
        ),
      ],
    );
  }
}

// ─── Form Card ────────────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final List<Widget> children;

  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.fTheme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// ─── Bio Field ────────────────────────────────────────────────────────────────

class _BioField extends StatelessWidget {
  final EditProfileController controller;

  const _BioField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'bio'.tr,
          style: TextStyle(
            fontSize: 13,
            color: context.fTheme.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.fTheme.colors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              QuillSimpleToolbar(
                controller: controller.quillBioController,
                config: QuillSimpleToolbarConfig(
                  multiRowsDisplay: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showStrikeThrough: false,
                  showInlineCode: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  showListCheck: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showIndent: false,
                  showUndo: false,
                  showRedo: false,
                  showSearchButton: false,
                  showClipboardCut: false,
                  showClipboardCopy: false,
                  showClipboardPaste: false,
                  showDirection: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showSmallButton: true,
                  showLineHeightButton: false,
                  showClearFormat: true,
                  showDividers: false,
                ),
              ),
              Divider(height: 1, color: context.fTheme.colors.border),
              QuillEditor(
                controller: controller.quillBioController,
                focusNode: controller.bioFocusNode,
                scrollController: controller.bioScrollController,
                config: QuillEditorConfig(
                  placeholder: 'bio_hint'.tr,
                  minHeight: 100,
                  maxHeight: 200,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Partner Card ─────────────────────────────────────────────────────────────

class _PartnerCard extends StatelessWidget {
  final EditProfileController controller;

  const _PartnerCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.fTheme.colors.border),
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
          _LocationSection(controller: controller),
          const SizedBox(height: 16),
          Divider(color: context.fTheme.colors.border),
          const SizedBox(height: 12),
          _UploadRow(
            icon: FIcons.camera,
            label: 'selfie_image'.tr,
            onPicked: (f) => controller.selfieFile.value = f,
            onRemoved: () => controller.selfieFile.value = null,
          ),
          const SizedBox(height: 12),
          _UploadRow(
            icon: FIcons.idCard,
            label: 'identity_card_image_front'.tr,
            onPicked: (f) => controller.frontCardFile.value = f,
            onRemoved: () => controller.frontCardFile.value = null,
          ),
          const SizedBox(height: 12),
          _UploadRow(
            icon: FIcons.idCard,
            label: 'identity_card_image_back'.tr,
            onPicked: (f) => controller.backCardFile.value = f,
            onRemoved: () => controller.backCardFile.value = null,
          ),
        ],
      ),
    );
  }
}

class _UploadRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function(dynamic) onPicked;
  final VoidCallback onRemoved;

  const _UploadRow({
    required this.icon,
    required this.label,
    required this.onPicked,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: context.fTheme.colors.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        UploadPhoto(onImagePicked: onPicked, onImageRemoved: onRemoved),
      ],
    );
  }
}

// ─── Location Section ─────────────────────────────────────────────────────────

class _LocationSection extends StatelessWidget {
  final EditProfileController controller;

  const _LocationSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoadingProvinces = controller.provinces.isEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'province'.tr,
            style: TextStyle(
              fontSize: 13,
              color: context.fTheme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 6),
          _DropdownContainer(
            context: context,
            isDisabled: false,
            child: isLoadingProvinces
                ? _LoadingDropdown()
                : DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: controller.selectedProvince.value?.id,
                        hint: _DropdownHint(
                          text: 'select_province'.tr,
                          context: context,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        items: controller.provinces
                            .map(
                              (p) => DropdownMenuItem<int>(
                                value: p.id,
                                child: Text(p.name, style: context.typography.sm),
                              ),
                            )
                            .toList(),
                        onChanged: (int? value) {
                          if (value != null) {
                            controller.onProvinceChanged(
                              controller.provinces.firstWhere(
                                (p) => p.id == value,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            'district'.tr,
            style: TextStyle(
              fontSize: 13,
              color: context.fTheme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 6),
          Obx(() {
            final isLoadingWards = controller.isLoadingWards.value;
            final noProvince = controller.selectedProvince.value == null;

            return _DropdownContainer(
              context: context,
              isDisabled: noProvince,
              child: isLoadingWards
                  ? _LoadingDropdown()
                  : DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: controller.selectedWard.value?.id,
                          disabledHint: _DropdownHint(
                            text: 'select_province_first'.tr,
                            context: context,
                          ),
                          hint: _DropdownHint(
                            text: 'select_district'.tr,
                            context: context,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                          borderRadius: BorderRadius.circular(10),
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
                          onChanged: noProvince
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
        ],
      );
    });
  }
}

class _DropdownContainer extends StatelessWidget {
  final BuildContext context;
  final bool isDisabled;
  final Widget child;

  const _DropdownContainer({
    required this.context,
    required this.isDisabled,
    required this.child,
  });

  @override
  Widget build(BuildContext ctx) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDisabled
                ? context.fTheme.colors.border.withValues(alpha: 0.4)
                : context.fTheme.colors.border,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isDisabled
              ? context.fTheme.colors.muted.withValues(alpha: 0.15)
              : null,
        ),
        child: child,
      ),
    );
  }
}

class _DropdownHint extends StatelessWidget {
  final String text;
  final BuildContext context;

  const _DropdownHint({required this.text, required this.context});

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: context.fTheme.colors.mutedForeground,
        ),
      ),
    );
  }
}

class _LoadingDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
