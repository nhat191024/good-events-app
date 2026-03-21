import 'package:flutter_html/flutter_html.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'controller.dart';

import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/components/widget/badge.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      resizeToAvoidBottomInset: false,
      header: Container(
        padding: EdgeInsets.only(
          top: context.statusBarHeight + 8,
          left: 16,
          right: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
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
              'my_profile'.tr,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                Text('failed_to_load_profile'.tr),
                const SizedBox(height: 12),
                CustomButtonPlus(
                  onTap: () => controller.fetchProfile,
                  width: double.infinity,
                  btnText: 'retry'.tr,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 8,
                  borderColor: Colors.transparent,
                ),
              ],
            ),
          );
        }

        final joinedDate = profile.createdAt.isNotEmpty
            ? DateFormat(
                'MMMM d, yyyy',
              ).format(DateTime.parse(profile.createdAt))
            : '-';

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                FAvatar(
                  image: CachedNetworkImageProvider(
                    controller.profile.value!.avatarUrl,
                  ),
                  size: 100.0,
                  semanticsLabel: 'User avatar',
                  fallback: Text(
                    profile.name.isNotEmpty
                        ? profile.name[0].toUpperCase()
                        : '?',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (profile.partnerName != null)
                  RichText(
                    text: TextSpan(
                      text: '${'stage_name'.tr}: ',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                      children: [
                        TextSpan(
                          text: profile.partnerName,
                          style: Get.textTheme.bodyMedium?.copyWith(
                            color: context.fTheme.colors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),

                /// --- Role - Verification ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBadge(
                      text: profile.partnerName != null
                          ? 'partner'.tr
                          : 'customer'.tr,
                      backgroundColor: context.fTheme.colors.primary.withAlpha(
                        20,
                      ),
                      textColor: context.fTheme.colors.primary,
                    ),
                    const SizedBox(width: 8),
                    CustomBadge(
                      text: profile.isLegit ? 'verified'.tr : 'unverified'.tr,
                      backgroundColor: profile.isLegit
                          ? context.fTheme.colors.primary.withAlpha(20)
                          : context.fTheme.colors.mutedForeground.withAlpha(20),
                      textColor: profile.isLegit
                          ? context.fTheme.colors.primary
                          : context.fTheme.colors.mutedForeground,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// --- Stats ---
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: context.fTheme.colors.primaryForeground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildItem(
                        context,
                        FIcons.ticketCheck,
                        'completed_orders'.tr,
                        '${profile.stats.completedOrders}',
                        flip: true,
                        center: true,
                      ),
                      const SizedBox(width: 12),
                      _buildItem(
                        context,
                        FIcons.ticketX,
                        'cancellation_rate'.tr,
                        '${profile.stats.cancelledOrdersPct}%',
                        flip: true,
                        center: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// --- Basic Info ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.fTheme.colors.primaryForeground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildItem(context, FIcons.phone, 'Phone', profile.phone),
                      const SizedBox(height: 12),
                      _buildItem(context, FIcons.mail, 'Email', profile.email),
                      const SizedBox(height: 12),
                      _buildItem(
                        context,
                        FIcons.clock,
                        'joined'.tr,
                        joinedDate,
                      ),
                      if (profile.bio.isNotEmpty &&
                          profile.bio != '<p></p>') ...[
                        const SizedBox(height: 12),
                        _buildItem(
                          context,
                          FIcons.info,
                          'About',
                          profile.bio,
                          isHtml: true,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// --- Identity Info ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.fTheme.colors.primaryForeground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildItem(
                        context,
                        FIcons.building,
                        'location'.tr,
                        profile.location,
                      ),
                      if (profile.identityCardNumber != null) ...[
                        const SizedBox(height: 12),
                        _buildItem(
                          context,
                          FIcons.banknote,
                          'id_number'.tr,
                          profile.identityCardNumber!,
                        ),
                      ],
                      if (profile.frontIdentityCardImage != null ||
                          profile.backIdentityCardImage != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              FIcons.idCard,
                              color: context.fTheme.colors.primary,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'id_card'.tr,
                              style: context.typography.xs.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (profile.frontIdentityCardImage != null)
                              Expanded(
                                child: _buildIdCardImage(
                                  context,
                                  profile.frontIdentityCardImage!,
                                  'front'.tr,
                                ),
                              ),
                            if (profile.frontIdentityCardImage != null &&
                                profile.backIdentityCardImage != null)
                              const SizedBox(width: 8),
                            if (profile.backIdentityCardImage != null)
                              Expanded(
                                child: _buildIdCardImage(
                                  context,
                                  profile.backIdentityCardImage!,
                                  'back'.tr,
                                ),
                              ),
                          ],
                        ),
                        if (profile.selfieImage != null)
                          _buildIdCardImage(
                            context,
                            profile.selfieImage!,
                            'selfie_image'.tr,
                          ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                /// --- Button ---
                CustomButtonPlus(
                  onTap: () => Get.toNamed(
                    Routes.editProfile,
                    arguments: controller.profile.value,
                  ),
                  width: double.infinity,
                  btnText: 'edit_profile'.tr,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 8,
                  borderColor: Colors.transparent,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildIdCardImage(
    BuildContext context,
    String imageUrl,
    String label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              height: 110,
              color: context.fTheme.colors.muted,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              height: 110,
              color: context.fTheme.colors.muted,
              child: Center(
                child: Icon(
                  FIcons.imageOff,
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.typography.xs.copyWith(
            color: context.fTheme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String title,
    String content, {
    bool isHtml = false,
    bool flip = false,
    bool useIcon = true,
    bool center = false,
  }) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (flip) ...[
          isHtml
              ? Html(data: content)
              : Text(
                  content,
                  style: context.typography.base.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
          Row(
            children: [
              if (useIcon)
                Icon(icon, color: context.fTheme.colors.primary, size: 12),
              if (useIcon) const SizedBox(width: 4),
              Text(
                title,
                style: context.typography.xs.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ] else ...[
          Row(
            children: [
              if (useIcon)
                Icon(icon, color: context.fTheme.colors.primary, size: 12),
              if (useIcon) const SizedBox(width: 4),
              Text(
                title,
                style: context.typography.xs.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          isHtml
              ? Html(data: content)
              : Text(
                  content,
                  style: context.typography.sm.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ],
      ],
    );
  }
}
