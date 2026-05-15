import 'package:get/get.dart';

/// Password rule descriptor used by [PasswordStrengthChecker].
class PasswordRule {
  const PasswordRule({required this.label, required this.test});

  final String label;
  final bool Function(String) test;
}

class AppValidators {
  AppValidators._();

  // ---------------------------------------------------------------------------
  // Password rules – mirrors Laravel server-side policy:
  //   Password::min(12)->mixedCase()->letters()->numbers()->symbols()->uncompromised()
  // ---------------------------------------------------------------------------

  static final List<PasswordRule> passwordRules = [
    PasswordRule(
      label: 'password_rule_min_length',
      test: (v) => v.length >= 12,
    ),
    PasswordRule(
      label: 'password_rule_letters',
      test: (v) => v.contains(RegExp(r'[a-zA-Z]')),
    ),
    PasswordRule(
      label: 'password_rule_mixed_case',
      test: (v) =>
          v.contains(RegExp(r'[A-Z]')) && v.contains(RegExp(r'[a-z]')),
    ),
    PasswordRule(
      label: 'password_rule_numbers',
      test: (v) => v.contains(RegExp(r'[0-9]')),
    ),
    PasswordRule(
      label: 'password_rule_symbols',
      test: (v) => v.contains(RegExp(r'[^a-zA-Z0-9]')),
    ),
  ];

  /// Returns the first failing rule's translated message, or `null` if all pass.
  static String? validatePassword(String? value) {
    final v = value ?? '';
    for (final rule in passwordRules) {
      if (!rule.test(v)) {
        return rule.label.tr;
      }
    }
    return null;
  }
}
