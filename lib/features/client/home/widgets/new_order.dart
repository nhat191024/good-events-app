import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/bottom_navigation/controller.dart';

class NewOrderPanel extends StatefulWidget {
  const NewOrderPanel({super.key});

  @override
  State<NewOrderPanel> createState() => _NewOrderPanelState();
}

class _NewOrderPanelState extends State<NewOrderPanel> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller?.forward().then((_) => _controller?.reverse());
        Get.find<ClientBottomNavigationController>().setIndex(1);
      },
      child:
          Container(
                padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE48729),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.star, color: Colors.white, size: 36),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'new_applicant'.trParams({'count': '2+'}),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'waiting_for_response'.tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    // if (controller.reviewers.isNotEmpty) ...[
                    const Spacer(),
                    // width is calculated to fit 5 items (4 overlaps + base avatar)
                    SizedBox(
                      width: 38 + (22 * 4),
                      height: 38,
                      child: Stack(clipBehavior: Clip.none, children: _buildAvatarList()),
                    ),
                    // ] else ...[
                    //TODO: handle empty state when have data
                    //   const Spacer(),
                    //   const _AvatarWidget(isLast: true),
                    // ],
                  ],
                ),
              )
              .animate(
                autoPlay: false,
                onInit: (controller) => _controller = controller,
              )
              .scaleXY(end: 0.95, duration: 100.ms, curve: Curves.easeInOut),
    ).animate(delay: 350.ms).fadeIn(duration: 200.ms);
  }

  // NOTE: For showcase purpose we use fake data here.
  List<Widget> _buildAvatarList() {
    final fakeReviewers = [
      'https://i.pravatar.cc/150?img=12',
      'https://i.pravatar.cc/150?img=5',
      '', // empty -> show placeholder icon
      'https://i.pravatar.cc/150?img=8',
      'https://i.pravatar.cc/150?img=20',
    ];

    List<Widget> avatars = [];
    final reviewerCount = fakeReviewers.length;
    final maxDisplayCount = 4;

    for (var i = 0; i < maxDisplayCount; i++) {
      if (i == maxDisplayCount - 1) {
        final remaining = reviewerCount - (maxDisplayCount - 1);
        avatars.add(
          Positioned(
            left: i * 22.0,
            child: _AvatarWidget(isLast: true, remaining: remaining),
          ),
        );
      } else if (i < reviewerCount) {
        final reviewerAvatar = fakeReviewers[i];
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

    avatars.add(Positioned(left: maxDisplayCount * 22.0, child: const _MoreAvatarButton()));

    return avatars;
  }
}

class _AvatarWidget extends StatelessWidget {
  final String imagePath;
  final bool isLast;
  final int remaining;

  const _AvatarWidget({this.imagePath = '', this.isLast = false, this.remaining = 0});

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
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );
    }

    if (imagePath.isEmpty) {
      return const Icon(Icons.person, size: 20, color: AppColors.lightMutedForeground);
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
          return const Icon(Icons.person, size: 20, color: AppColors.lightMutedForeground);
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
      child: const Center(child: Icon(Icons.arrow_forward, color: Colors.white, size: 16)),
    );
  }
}
