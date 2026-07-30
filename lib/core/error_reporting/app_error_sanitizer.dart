import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class AppErrorSanitizer {
  static const String redactedValue = '[REDACTED]';
  static const String omittedBinaryValue = '[BINARY_OMITTED]';
  static const String omittedFileValue = '[FILE_OMITTED]';

  static const Set<String> _sensitiveKeys = <String>{
    'authorization',
    'token',
    'access_token',
    'refresh_token',
    'password',
    'password_confirmation',
    'otp',
    'secret',
    'api_key',
    'cookie',
    'set_cookie',
    'credit_card',
    'card_number',
    'cvv',
  };

  static dynamic sanitize(
    Object? value, {
    int maxDepth = 6,
    int maxStringLength = 8000,
  }) {
    return _sanitizeValue(
      value,
      depth: 0,
      maxDepth: maxDepth,
      maxStringLength: maxStringLength,
    );
  }

  static Map<String, dynamic> sanitizeMap(
    Map<dynamic, dynamic> value, {
    int maxDepth = 6,
    int maxStringLength = 8000,
  }) {
    final sanitized = sanitize(
      value,
      maxDepth: maxDepth,
      maxStringLength: maxStringLength,
    );
    return sanitized is Map<String, dynamic>
        ? sanitized
        : <String, dynamic>{'value': sanitized};
  }

  static Map<String, dynamic> sanitizePayloadMap(
    Map<dynamic, dynamic> value, {
    int maxEncodedLength = 16000,
  }) {
    final sanitized = sanitizeMap(value);
    final encoded = jsonEncode(sanitized);
    if (encoded.length <= maxEncodedLength) return sanitized;

    return <String, dynamic>{
      'content': _truncate(encoded, maxEncodedLength),
      'truncated': true,
    };
  }

  static String sanitizeUrl(Uri uri) {
    final query = <String, String>{};
    uri.queryParameters.forEach((key, value) {
      query[key] = _isSensitiveKey(key) ? redactedValue : redactText(value);
    });

    return uri
        .replace(queryParameters: query.isEmpty ? null : query)
        .toString();
  }

  static String redactText(String value, {int maxLength = 12000}) {
    var sanitized = value.replaceAllMapped(
      RegExp(
        r'(authorization|access_token|refresh_token|token|password|password_confirmation|otp|secret|api_key|cookie|set-cookie|credit_card|card_number|cvv)(\s*[:=]\s*)([^&\s,}\]]+)',
        caseSensitive: false,
      ),
      (match) => '${match.group(1)}${match.group(2)}$redactedValue',
    );
    sanitized = sanitized.replaceAll(
      RegExp(r'Bearer\s+[A-Za-z0-9\-._~+/]+=*', caseSensitive: false),
      'Bearer $redactedValue',
    );
    return _truncate(sanitized, maxLength);
  }

  static dynamic _sanitizeValue(
    Object? value, {
    required int depth,
    required int maxDepth,
    required int maxStringLength,
  }) {
    if (value == null || value is num || value is bool) return value;
    if (depth >= maxDepth) return '[MAX_DEPTH_REACHED]';
    if (value is String) {
      return redactText(value, maxLength: maxStringLength);
    }
    if (value is Uint8List || value is ByteBuffer || value is MultipartFile) {
      return omittedBinaryValue;
    }
    if (value is FormData) {
      final fields = <String, dynamic>{};
      for (final field in value.fields) {
        fields[field.key] = _isSensitiveKey(field.key)
            ? redactedValue
            : redactText(field.value, maxLength: maxStringLength);
      }
      if (value.files.isNotEmpty) {
        fields['files'] = value.files
            .map(
              (file) => <String, String>{
                'field': file.key,
                'content': omittedFileValue,
              },
            )
            .toList(growable: false);
      }
      return fields;
    }
    if (value is Map) {
      final result = <String, dynamic>{};
      for (final entry in value.entries) {
        final key = entry.key.toString();
        result[key] = _isSensitiveKey(key)
            ? redactedValue
            : _sanitizeValue(
                entry.value,
                depth: depth + 1,
                maxDepth: maxDepth,
                maxStringLength: maxStringLength,
              );
      }
      return result;
    }
    if (value is Iterable) {
      return value
          .take(100)
          .map(
            (item) => _sanitizeValue(
              item,
              depth: depth + 1,
              maxDepth: maxDepth,
              maxStringLength: maxStringLength,
            ),
          )
          .toList(growable: false);
    }
    return redactText(value.toString(), maxLength: maxStringLength);
  }

  static bool _isSensitiveKey(String key) {
    final normalized = key
        .trim()
        .toLowerCase()
        .replaceAll('-', '_')
        .replaceAll(' ', '_');
    if (_sensitiveKeys.contains(normalized)) return true;

    return normalized.endsWith('_token') ||
        normalized.contains('password') ||
        normalized.contains('credit_card') ||
        normalized.endsWith('_secret');
  }

  static String _truncate(String value, int maxLength) {
    if (value.length <= maxLength) return value;
    return '${value.substring(0, maxLength)}...[TRUNCATED]';
  }
}
