import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'app_error_reporter.dart';
import 'app_error_types.dart';

class AppErrorLogBridge {
  AppErrorLogBridge._();

  static bool _isInstalled = false;
  static AppErrorReporter? _reporter;

  static void install({required AppErrorReporter reporter}) {
    if (_isInstalled) return;

    _reporter = reporter;
    Logger.addLogListener(_handleLogEvent);
    _isInstalled = true;
  }

  static bool shouldReport(LogEvent event) {
    final isErrorLevel =
        event.level.value >= Level.error.value &&
        event.level.value < Level.off.value;
    if (!isErrorLevel || event.error == null) return false;

    // Dio failures are already reported by ErrorReportingInterceptor. Some
    // legacy call sites pass only DioException.message as the error object.
    final message = event.message.toString();
    if (event.error is DioException ||
        message.toLowerCase().contains('dioexception')) {
      return false;
    }

    // Global handlers submit the original error and stack trace directly.
    return !message.startsWith('[GlobalErrorHandler]');
  }

  static void _handleLogEvent(LogEvent event) {
    try {
      final reporter = _reporter;
      if (reporter == null || !shouldReport(event)) return;

      final error = event.error!;
      final loggerMessage = event.message.toString();
      final errorMessage = error.toString();
      final message = loggerMessage.contains(errorMessage)
          ? loggerMessage
          : '$loggerMessage: $errorMessage';

      unawaited(
        reporter.reportError(
          type: AppErrorType.runtime,
          severity: event.level.value >= Level.fatal.value
              ? AppErrorSeverity.fatal
              : AppErrorSeverity.error,
          message: message,
          source: 'Logger',
          error: error,
          stackTrace: event.stackTrace ?? StackTrace.current,
          occurredAt: event.time,
          context: <String, dynamic>{
            'captured_from': 'logger',
            'log_level': event.level.name,
          },
        ),
      );
    } catch (_) {
      // Logging and reporting must never affect the application flow.
    }
  }
}
