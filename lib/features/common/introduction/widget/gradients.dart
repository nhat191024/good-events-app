import 'package:sukientotapp/core/utils/import/global.dart';

class IntroTopGradient extends StatelessWidget {
  /// improve readability of the intro text
  const IntroTopGradient({super.key});

  static const topGradientBg = [
    AppColors.amber400,
    Color.fromARGB(236, 255, 243, 180),
    Color.fromARGB(97, 255, 248, 214),
    Color.fromARGB(0, 255, 230, 104),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: topGradientBg,
            begin: Alignment.topCenter,
            stops: [
              0.0,
              0.8,
              0.95,
              1.0,
            ],
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class IntroBottomGradient extends StatelessWidget {
  /// make 'skip' button easier to see (it's hard due to transparency)
  const IntroBottomGradient({super.key});

  static const bottomGradientBg = [
    Color(0xAA000000),
    Color(0x44000000),
    Colors.transparent,
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bottomGradientBg,
            begin: Alignment.bottomCenter,
            stops: [
              0.0,
              0.35,
              1.0,
            ],
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
