import 'app_error_types.dart';

class AppErrorReportRequest {
  final AppErrorType type;
  final AppErrorSeverity severity;
  final String message;
  final String? customType;
  final String? errorCode;
  final String? source;
  final String? stackTrace;
  final Map<String, dynamic>? context;
  final String? apiMethod;
  final String? apiUrl;
  final int? apiStatusCode;
  final Map<String, dynamic>? apiRequest;
  final Map<String, dynamic>? apiResponse;
  final DateTime occurredAt;

  const AppErrorReportRequest({
    required this.type,
    required this.message,
    required this.occurredAt,
    this.severity = AppErrorSeverity.error,
    this.customType,
    this.errorCode,
    this.source,
    this.stackTrace,
    this.context,
    this.apiMethod,
    this.apiUrl,
    this.apiStatusCode,
    this.apiRequest,
    this.apiResponse,
  });

  Map<String, dynamic> toJson() {
    if (type == AppErrorType.other &&
        (customType == null || customType!.trim().isEmpty)) {
      throw StateError('customType is required when type is other');
    }
    if (type == AppErrorType.api &&
        ((apiMethod == null || apiMethod!.trim().isEmpty) ||
            (apiUrl == null || apiUrl!.trim().isEmpty))) {
      throw StateError('apiMethod and apiUrl are required when type is api');
    }

    return <String, dynamic>{
      'type': type.value,
      'severity': severity.value,
      'message': message,
      if (customType != null && customType!.trim().isNotEmpty)
        'custom_type': customType,
      if (errorCode != null && errorCode!.trim().isNotEmpty)
        'error_code': errorCode,
      if (source != null && source!.trim().isNotEmpty) 'source': source,
      if (stackTrace != null && stackTrace!.trim().isNotEmpty)
        'stack_trace': stackTrace,
      if (context != null && context!.isNotEmpty) 'context': context,
      if (apiMethod != null && apiMethod!.trim().isNotEmpty)
        'api_method': apiMethod!.trim().toUpperCase(),
      if (apiUrl != null && apiUrl!.trim().isNotEmpty) 'api_url': apiUrl,
      if (apiStatusCode != null) 'api_status_code': apiStatusCode,
      if (apiRequest != null && apiRequest!.isNotEmpty)
        'api_request': apiRequest,
      if (apiResponse != null && apiResponse!.isNotEmpty)
        'api_response': apiResponse,
      'occurred_at': formatOccurredAt(occurredAt),
    };
  }

  static String formatOccurredAt(DateTime value) {
    final local = value.toLocal();
    final offsetMinutes = local.timeZoneOffset.inMinutes;
    final sign = offsetMinutes < 0 ? '-' : '+';
    final absoluteMinutes = offsetMinutes.abs();
    final hours = (absoluteMinutes ~/ 60).toString().padLeft(2, '0');
    final minutes = (absoluteMinutes % 60).toString().padLeft(2, '0');

    return '${local.toIso8601String()}$sign$hours:$minutes';
  }
}
