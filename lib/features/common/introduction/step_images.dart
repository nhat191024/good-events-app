import 'package:sukientotapp/core/utils/import/global.dart';

///? those images are one-time use only so no need to declare on global AppImage
const List<IntroductionStepImages> introductionImages = [
  IntroductionStepImages(
    bg: 'assets/images/introduction/client-bg-step-1.webp',
    personA: 'assets/images/introduction/client-person-a-step-1.webp',
    personB: 'assets/images/introduction/client-person-b-step-1.webp',
  ),
  IntroductionStepImages(
    bg: 'assets/images/introduction/client-bg-step-2.webp',
    personA: 'assets/images/introduction/client-person-a-step-2.webp',
    personB: 'assets/images/introduction/client-person-b-step-2.webp',
  ),
  IntroductionStepImages(
    bg: 'assets/images/introduction/client-bg-step-3.webp',
    personA: AppImages.blankImage,
    personB: AppImages.blankImage,
  ),
];

/// [introductionImages] counterpart
const List<IntroductionStepImages> partnerIntroductionImages = [
  IntroductionStepImages(
    bg: 'assets/images/introduction/partner-bg-step-1.webp',
    personB: 'assets/images/introduction/partner-person-b-step-1.webp',
    personA: 'assets/images/introduction/partner-person-a-step-1.webp',
  ),
  IntroductionStepImages(
    bg: 'assets/images/introduction/partner-bg-step-2.webp',
    personA: 'assets/images/introduction/partner-person-a-step-2.webp',
    personB: 'assets/images/introduction/partner-person-b-step-2.webp',
  ),
  IntroductionStepImages(
    bg: 'assets/images/introduction/partner-bg-step-3.webp',
    personA: 'assets/images/introduction/partner-person-a-step-3.webp',
    personB: AppImages.blankImage,
  ),
];

/// lang keys
const List<String> introductionIntroTextKeys = [
  'client_step_1_intro',
  'client_step_2_intro',
  'client_step_3_intro',
];

/// lang keys
const List<String> partnerIntroductionIntroTextKeys = [
  'partner_step_1_intro',
  'partner_step_2_intro',
  'partner_step_3_intro',
];

/// Image type keys. choose either [bg] or [personA] or [personB]
enum IntroImageKey {
  bg,

  /// transparent image for putting on the left-hand side of the bg
  personA,

  /// puting on the right-hand side of the bg
  personB,
}

/// For getting one-time-use intro images
class IntroductionStepImages {
  final String bg;
  final String personA;
  final String personB;

  const IntroductionStepImages({
    required this.bg,
    required this.personA,
    required this.personB,
  });

  String byKey(IntroImageKey key) {
    switch (key) {
      case IntroImageKey.bg:
        return bg;
      case IntroImageKey.personA:
        return personA;
      case IntroImageKey.personB:
        return personB;
    }
  }

  static String getIntroImage({
    required bool isServiceProvider,
    required int step,
    required IntroImageKey key,
  }) {
    final images = isServiceProvider
        ? partnerIntroductionImages
        : introductionImages;

    return images[step].byKey(key);
  }

  /// use in controller
  static String getIntroTextKey({
    required bool isServiceProvider,
    required int step,
  }) {
    final keys = isServiceProvider
        ? partnerIntroductionIntroTextKeys
        : introductionIntroTextKeys;

    /// prevents 'index out of bound' thing
    final int safeStep = step < 0
        ? 0
        : (step >= keys.length ? keys.length - 1 : step);

    return keys[safeStep];
  }
}
