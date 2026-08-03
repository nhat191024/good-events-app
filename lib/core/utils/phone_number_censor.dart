/// Censors Vietnamese phone numbers embedded in chat content.
abstract final class PhoneNumberCensor {
  static final RegExp _vietnamesePhonePattern = RegExp(
    r'(?<!\d)(?:\+?84|0)(?:[\s.-]*\d){9}(?!\d)',
  );

  static String censor(String text) {
    return text.replaceAllMapped(_vietnamesePhonePattern, (match) {
      final String rawPhone = match.group(0)!;
      final String digits = rawPhone.replaceAll(RegExp(r'\D'), '');
      final String localDigits = digits.startsWith('84')
          ? '0${digits.substring(2)}'
          : digits;

      return '${localDigits.substring(0, 3)}*****';
    });
  }
}
