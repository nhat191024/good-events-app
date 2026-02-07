import 'package:sukientotapp/core/utils/import/global.dart';

import 'controller.dart';

class ChooseYoSideScreen extends GetView<ChooseYoSideController> {
  const ChooseYoSideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double splitRatio = 0.51;
    final double slopeHeight = 150.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Stack(
          children: [
            //Service Provider Section
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    loggerNoStack.i("Service Provider section tapped");
                  }
                  controller.isServiceProvider.value = true;
                },
                child: Obx(
                  () => ClipPath(
                    clipper: BottomStackClipper(
                      splitRatio: splitRatio,
                      slopeHeight: slopeHeight,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: controller.isServiceProvider.value
                              ? [
                                  Colors.red[900]!, // Primary color
                                  Colors.red[300]!, // White-ish
                                  Colors.white, // Pure white (if desired)
                                ]
                              : [
                                  Colors.grey[800]!, // Primary color
                                  Colors.grey[350]!, // White-ish
                                  Colors.white, // Pure white (if desired)
                                ],
                          begin:
                              Alignment.topLeft, // Start from top-left corner
                          end: Alignment
                              .bottomRight, // End at bottom-right corner
                          stops: const [
                            0.0,
                            0.7,
                            1.0,
                          ], // Adjust the spread of colors
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 140),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 240,
                                width: 240,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image.asset(
                                    AppImages.partnerSplash,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'service_provider'.tr.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: controller.isServiceProvider.value
                                      ? Colors.red[900]
                                      : Colors.brown[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Customer Section
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    loggerNoStack.i("Customer section tapped");
                  }
                  controller.isServiceProvider.value = false;
                },
                child: Obx(
                  () => ClipPath(
                    clipper: TopStackClipper(
                      splitRatio: splitRatio,
                      slopeHeight: slopeHeight,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: controller.isServiceProvider.value
                              ? [
                                  Colors.grey[800]!, // Primary color
                                  Colors.grey[350]!, // White-ish
                                  Colors.white, // Pure white (if desired)
                                ]
                              : [
                                  Color(
                                    0xFFFFF8E1,
                                  ), // White-ish yellow (top-left corner)
                                  Color(
                                    0xFFF59E0B,
                                  ), // Primary color (bottom-right corner)
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'customer'.tr.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 260,
                                width: 260,
                                child: Image.asset(
                                  AppImages.clientSplash,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Text(
                'title_choose_your_side'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: FTappable(
                onPress: () => Get.toNamed(
                  Routes.introduction,
                  arguments: {
                    'isServiceProvider': controller.isServiceProvider.value,
                  },
                ),
                builder: (context, states, child) {
                  return Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: controller.isServiceProvider.value
                            ? AppColors.primary
                            : AppColors.amber400,
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  'next'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const double kGap = 30.0; // Khoảng trắng giữa 2 khối
const double kCurveRadius = 40.0; // Độ bo tròn góc cắt

class TopStackClipper extends CustomClipper<Path> {
  final double splitRatio;
  final double slopeHeight;

  TopStackClipper({required this.splitRatio, required this.slopeHeight});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerHeight = size.height * splitRatio;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    double rightPointY = centerHeight + (slopeHeight / 2);
    double leftPointY = centerHeight - (slopeHeight / 2);

    path.lineTo(size.width, rightPointY - kCurveRadius);
    path.quadraticBezierTo(
      size.width,
      rightPointY,
      size.width - kCurveRadius,
      rightPointY - (kCurveRadius * slopeHeight / size.width * 0.8),
    );

    path.lineTo(
      kCurveRadius,
      leftPointY + (kCurveRadius * slopeHeight / size.width * 0.8),
    );
    path.quadraticBezierTo(0, leftPointY, 0, leftPointY - kCurveRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant TopStackClipper oldClipper) => true;
}

class BottomStackClipper extends CustomClipper<Path> {
  final double splitRatio;
  final double slopeHeight;

  BottomStackClipper({required this.splitRatio, required this.slopeHeight});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerHeight = size.height * splitRatio;

    double rightPointY = centerHeight + (slopeHeight / 2) + kGap;
    double leftPointY = centerHeight - (slopeHeight / 2) + kGap;

    path.moveTo(0, leftPointY + kCurveRadius);
    path.quadraticBezierTo(
      0,
      leftPointY,
      kCurveRadius,
      leftPointY + (kCurveRadius * slopeHeight / size.width * 0.8),
    );
    path.lineTo(
      size.width - kCurveRadius,
      rightPointY - (kCurveRadius * slopeHeight / size.width * 0.8),
    );

    path.quadraticBezierTo(
      size.width,
      rightPointY,
      size.width,
      rightPointY + kCurveRadius,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant BottomStackClipper oldClipper) => true;
}
