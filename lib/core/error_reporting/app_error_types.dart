enum AppErrorType {
  api,
  runtime,
  network,
  validation,
  authentication,
  ui,
  performance,
  other;

  String get value => name;
}

enum AppErrorSeverity {
  debug,
  info,
  warning,
  error,
  fatal;

  String get value => name;
}
