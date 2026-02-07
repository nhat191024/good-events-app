import 'effects.dart';

class SidePosition {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  const SidePosition({
    this.left,
    this.right,
    this.top,
    this.bottom,
  });
}

class StepPositions {
  final SidePosition left;
  final SidePosition right;
  const StepPositions({required this.left, required this.right});
}

/// INITIAL positions for each step (before the animation plays).
/// to modify the animation effects, check [effectsForStep]
StepPositions positionsForStep(
  int step, {
  required bool isServiceProvider,
}) {
  switch (step) {
    ///! case = step
    case 0:

      ///! partner side step 1
      if (isServiceProvider) {
        return StepPositions(
          ///* left side image
          left: SidePosition(
            left: 0,
            top: 190,
            bottom: 120,
          ),

          ///* right side image
          right: SidePosition(
            right: 0,
            top: 10,
            bottom: 300,
          ),
        );
      }

      ///! client side step 1
      return StepPositions(
        ///* right side image
        left: SidePosition(
          right: 120,
          top: 150,
          bottom: 330,
        ),

        ///* left side image
        right: SidePosition(
          right: 80,
          top: 320,
          bottom: 40,
        ),
      );
    case 1:

      ///! partner side step 2
      if (isServiceProvider) {
        return StepPositions(
          ///* left side image
          left: SidePosition(
            left: 30,
            right: 10,
            top: 300,
            bottom: 20,
          ),

          ///* right side image
          right: SidePosition(
            right: 300,
            top: 200,
            bottom: 390,
          ),
        );
      }

      ///! client side step 2
      return StepPositions(
        ///* left side image
        left: SidePosition(
          left: 0,
          top: 0,
          bottom: 380,
        ),

        ///* right side image
        right: SidePosition(
          right: 10,
          top: 260,
          bottom: 150,
        ),
      );
    default:

      ///! partner side step 3
      if (isServiceProvider) {
        return StepPositions(
          ///* left side image
          left: SidePosition(
            left: 9,
            top: 100,
            bottom: 225,
          ),

          ///* right side image
          right: SidePosition(
            right: -65,
            top: 70,
            bottom: 230,
          ),
        );
      }

      ///! client side step 3
      return StepPositions(
        ///* left side image
        left: SidePosition(
          right: 0,
          top: 0,
          bottom: 0,
        ),

        ///* right side image
        right: SidePosition(
          right: 0,
          top: 0,
          bottom: 0,
        ),
      );
  }
}
