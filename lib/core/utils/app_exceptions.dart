class UnverifiedUserException implements Exception {
  final String message;
  final Map<String, dynamic> data;

  const UnverifiedUserException({
    this.message = 'Tài khoản chưa được xác thực.',
    this.data = const {},
  });

  @override
  String toString() => 'UnverifiedUserException: $message';
}

/// Thrown when server returns 429 with code OTP_COOLDOWN.
/// [retryAfter] is the remaining cooldown in seconds (if provided by server).
class OtpCooldownException implements Exception {
  final String message;
  final int? retryAfter;

  OtpCooldownException({this.message = 'otp_cooldown', this.retryAfter});

  @override
  String toString() => 'OtpCooldownException: $message';
}

/// Thrown when server returns 429 with code MAX_ATTEMPTS.
class OtpMaxAttemptsException implements Exception {
  final String message;
  final int? retryAfter;

  const OtpMaxAttemptsException({this.message = 'otp_max_attempts', this.retryAfter});

  @override
  String toString() => 'OtpMaxAttemptsException: $message';
}

/// Thrown when server returns 422 with code INVALID_OTP.
class OtpInvalidException implements Exception {
  final String message;

  const OtpInvalidException({this.message = 'otp_invalid'});

  @override
  String toString() => 'OtpInvalidException: $message';
}

/// Thrown when server returns 404 with code USER_NOT_FOUND.
class UserNotFoundException implements Exception {
  final String message;

  const UserNotFoundException({this.message = 'user_not_found'});

  @override
  String toString() => 'UserNotFoundException: $message';
}

/// Thrown when server returns 422 with code INVALID_TOKEN.
class InvalidTokenException implements Exception {
  final String message;

  const InvalidTokenException({this.message = 'invalid_token'});

  @override
  String toString() => 'InvalidTokenException: $message';
}

/// Thrown when server returns 422 with password validation error codes.
/// [codes] mirrors the Laravel error code keys, e.g. ["PASSWORD_COMPROMISED"].
/// Codes that can be validated client-side (MIN_LENGTH_NOT_MET, etc.) will
/// normally never arrive here because the form validator blocks submission first.
class PasswordValidationException implements Exception {
  final List<String> codes;

  const PasswordValidationException(this.codes);

  @override
  String toString() => 'PasswordValidationException: $codes';
}
