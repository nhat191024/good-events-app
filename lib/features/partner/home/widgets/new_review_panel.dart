import 'package:sukientotapp/core/utils/import/global.dart';

class NewReviewPanel extends StatelessWidget {
  final int recentReviewsCount;
  final Map<String, String> recentReviewsAvatars;

  const NewReviewPanel({
    super.key,
    required this.recentReviewsCount,
    required this.recentReviewsAvatars,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(FIcons.star, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'new_rate'.trParams({'rates': recentReviewsCount > 99 ? '99+' : recentReviewsCount.toString()}),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'from_clients'.tr,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // if (controller.reviewers.isNotEmpty) ...[
            const Spacer(),
            if (recentReviewsAvatars.isNotEmpty)
              SizedBox(
                width: 38 + (22.0 * (recentReviewsAvatars.length < 4 ? recentReviewsAvatars.length : 4)),
                height: 38,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: _buildAvatarList(),
                ),
              )
            else
              const _AvatarWidget(isLast: true),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAvatarList() {
    final avatarUrls = recentReviewsAvatars.values.toList();

    List<Widget> avatars = [];
    final reviewerCount = avatarUrls.length;
    final maxDisplayCount = 4;

    for (var i = 0; i < maxDisplayCount; i++) {
      if (i == maxDisplayCount - 1 && reviewerCount >= maxDisplayCount) {
        final remaining = reviewerCount - (maxDisplayCount - 1);
        avatars.add(
          Positioned(
            left: i * 22.0,
            child: _AvatarWidget(isLast: true, remaining: remaining),
          ),
        );
      } else if (i < reviewerCount) {
        final reviewerAvatar = avatarUrls[i];
        avatars.add(
          Positioned(
            left: i * 22.0,
            child: _AvatarWidget(imagePath: reviewerAvatar),
          ),
        );
      } else {
        break;
      }
    }

    if (reviewerCount > 0) {
      avatars.add(
        Positioned(
          left: (avatars.length < maxDisplayCount ? avatars.length : maxDisplayCount) * 22.0,
          child: const _MoreAvatarButton(),
        ),
      );
    }

    return avatars;
  }
}

class _AvatarWidget extends StatelessWidget {
  final String imagePath;
  final bool isLast;
  final int remaining;

  const _AvatarWidget({
    this.imagePath = '',
    this.isLast = false,
    this.remaining = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.lightMuted,
        child: _buildAvatarContent(context),
      ),
    );
  }

  Widget _buildAvatarContent(BuildContext context) {
    if (isLast) {
      final displayText = remaining > 0 ? '+$remaining' : '';
      return Center(
        child: Text(
          displayText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    if (imagePath.isEmpty) {
      return const Icon(
        Icons.person,
        size: 20,
        color: AppColors.lightMutedForeground,
      );
    }

    return ClipOval(
      child: Image.network(
        imagePath,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.person,
            size: 20,
            color: AppColors.lightMutedForeground,
          );
        },
      ),
    );
  }
}

class _MoreAvatarButton extends StatelessWidget {
  const _MoreAvatarButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.red600,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const Center(
        child: Icon(Icons.arrow_forward, color: Colors.white, size: 16),
      ),
    );
  }
}
