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
