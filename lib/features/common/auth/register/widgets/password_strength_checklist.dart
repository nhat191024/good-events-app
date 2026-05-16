import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sukientotapp/core/utils/app_validators.dart';

/// Displays a real-time checklist of password rules.
/// Pass the [controller] from the password [TextEditingController].
class PasswordStrengthChecklist extends StatelessWidget {
  const PasswordStrengthChecklist({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final password = value.text;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AppValidators.passwordRules.map((rule) {
            final passed = rule.test(password);
            return _RuleRow(label: rule.label.tr, passed: passed);
          }).toList(),
        );
      },
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.passed});

  final String label;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    final color = passed ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(
            passed ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}
