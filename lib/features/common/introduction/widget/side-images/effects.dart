import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'positions.dart';

/// [isLeft] = true means this image is on the left side of the screen.
/// to change initial position (before those effects start) check [positionsForStep]

/// note: which side is left? and right??
///* be careful! do not mix up left & right
/// (xleft & yleft) = left side image
/// (xright & yright) = right side image
/// pay attention to the (x & y) difference

/// ironically, the [begin] param is the FINAL position after animation
/// and the [end] param is the START position before animation
/// i have no idea why but it works
List<Effect> effectsForStep(
  int step, {
  required bool isLeft,
  required bool isServiceProvider,
}) {
  final offsetZero = Offset(0, 0);
  final offsetOne = Offset(1, 1);

  switch (step) {
    ///! case = step
    case 0:

      ///! partner side step 1
      if (isServiceProvider) {
        return [
          SlideEffect(
            begin: Offset(
              ///       xleft   xright
              (isLeft ? -1.50 : 1.50),

              ///       yleft  yright
              (isLeft ? 0.15 : 0.15),
            ),
            end: offsetZero,
            duration: 800.ms,
            curve: Curves.bounceInOut,
          ),
        ];
      }

      ///! client side step 1
      return [
        SlideEffect(
          begin: Offset(
            ///       xleft  xright
            (isLeft ? 0.00 : 0.00),

            ///       yleft  yright
            (isLeft ? 1.35 : 0.00),
          ),
          end: offsetZero,
          duration: isServiceProvider ? 2000.ms : 850.ms,
          curve: isServiceProvider
              ? Curves.easeOutBack
              : Curves.fastEaseInToSlowEaseOut,
        ),
        ScaleEffect(
          begin: Offset(
            ///       xleft  xright
            (isLeft ? 0.00 : 0.80),

            ///       yleft  yright
            (isLeft ? 0.00 : 0.80),
          ),
          end: offsetOne,
          duration: 1500.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
        ),
      ];
    case 1:

      ///! partner side step 2
      if (isServiceProvider) {
        return [
          SlideEffect(
            begin: Offset(
              ///       xleft   xright
              (isLeft ? -0.20 : 0.60),

              ///       yleft   yright
              (isLeft ? 0.00 : -0.20),
            ),
            end: offsetZero,
            duration: (isLeft ? 150.ms : 1500.ms),
            curve: (isLeft ? Curves.ease : Curves.fastOutSlowIn),
          ),
          ScaleEffect(
            begin: Offset(
              ///       xleft  xright
              (isLeft ? 0.80 : 5.00),

              ///       yleft  yright
              (isLeft ? 0.80 : 5.00),
            ),
            end: offsetOne,
            duration: 1500.ms,
            curve: Curves.easeOutBack,
          ),
          RotateEffect(
            begin: (isLeft ? -0.04 : 0.05),
            end: 0,
            duration: 1500.ms,
            curve: Curves.easeOutBack,
          ),
        ];
      }

      ///! client side step 2
      return [
        SlideEffect(
          begin: offsetZero,
          end: Offset(
            ///       xleft  xright
            (isLeft ? -1.50 : 1.50),

            ///       yleft  yright
            (isLeft ? 0.00 : 0.50),
          ),
          duration: 2100.ms,
          curve: Curves.easeInBack,
        ),
        ScaleEffect(
          begin: offsetOne,
          end: Offset(
            ///       xleft  xright
            (isLeft ? 0.90 : 0.90),

            ///       yleft  yright
            (isLeft ? 0.90 : 0.90),
          ),
          duration: 1500.ms,
          curve: Curves.easeInBack,
        ),
        RotateEffect(
          begin: (isLeft ? 0.01 : 0.02),
          end: 0,
          duration: 1500.ms,
          curve: Curves.easeOutBack,
        ),
      ];
    default:

      ///! partner side step 3
      if (isServiceProvider) {
        return [
          ScaleEffect(
            begin: Offset(
              ///       xleft  xright
              (isLeft ? 0.00 : 0.00),

              ///       yleft  yright
              (isLeft ? 0.00 : 0.00),
            ),
            end: offsetOne,
            duration: 2050.ms,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
          RotateEffect(
            begin: (isLeft ? -0.08 : 0.05),
            end: 0,
            duration: 1500.ms,
            curve: Curves.easeOutBack,
          ),
        ];
      }

      ///! client side step 3
      return [
        SlideEffect(
          begin: Offset(
            ///       xleft  xright
            (isLeft ? -0.15 : 0.15),

            ///       yleft  yright
            (isLeft ? 0.00 : 0.00),
          ),
          end: Offset(
            ///       xleft  xright
            (isLeft ? 0.00 : 0.00),

            ///       yleft  yright
            (isLeft ? 0.00 : 0.00),
          ),
          duration: 650.ms,
          curve: Curves.easeIn,
        ),
      ];
  }
}
