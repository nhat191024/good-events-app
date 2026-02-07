import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'positions.dart';

Widget leftImage({
  required String path,
  required double height,
  SidePosition? position,
  List<Effect>? effects,
  required int step,
  bool playOnEnter = true,
}) {
  return personImage(
    path: path,
    height: height,
    keyId: 'personA-$step',
    position: position,
    effects: effects,
    currentStep: step,
    playOnEnter: playOnEnter,
  );
}

Widget rightImage({
  required String path,
  required double height,
  SidePosition? position,
  List<Effect>? effects,
  required int step,
  bool playOnEnter = true,
}) {
  return personImage(
    path: path,
    height: height,
    keyId: 'personB-$step',
    position: position,
    effects: effects,
    currentStep: step,
    playOnEnter: playOnEnter,
  );
}

/// building the image widget with the given position and effects
Widget personImage({
  required String path,
  required double height,
  required String keyId,
  required int currentStep,
  bool playOnEnter = true,
  SidePosition? position,
  List<Effect>? effects,
}) {
  final SidePosition safePosition = position ?? const SidePosition();
  final List<Effect> safeEffects = effects ?? const [];

  /// logic for toggling [playOnEnter]
  final int targetStep = currentStep + (playOnEnter ? 1 : 0);

  /// because [Animate.animate()]'s [target] param only works when the value is
  /// between 0 and 1, so when currentStep goes higher than 1 (>=2), it stopped
  /// working, hence the below solution
  final double targetValue = (targetStep % 2).toDouble();
  return Positioned(
    left: safePosition.left,
    right: safePosition.right,
    top: safePosition.top,
    bottom: safePosition.bottom,
    child:
        Image.asset(
          path,
          key: ValueKey(keyId),
          height: height,
          fit: BoxFit.contain,
        ).animate(
          effects: safeEffects,
          autoPlay: true,

          /// it works now!!
          target: targetValue,
        ),
  );
}
