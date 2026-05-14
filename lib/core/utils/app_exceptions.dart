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

  const OtpMaxAttemptsException({this.message = 'otp_max_attempts'});

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
