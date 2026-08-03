import 'dart:async';
import 'package:dio/dio.dart';
import 'app_error_reporter.dart';

class ErrorReportingInterceptor extends Interceptor {
  final AppErrorReporter reporter;

  ErrorReportingInterceptor({required this.reporter});

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    if (AppErrorReporter.isEnabled &&
        error.requestOptions.extra['skipErrorReporting'] != true) {
      unawaited(reporter.reportApiError(error));
    }
    handler.next(error);
  }
}
