import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_super_snackbar/getx_super_snackbar.dart';

class AppSnackbar {
  AppSnackbar._();

  static const SnackPosition _defaultPosition = SnackPosition.TOP;
  static const Duration _defaultDuration = Duration(seconds: 3);

  /// success - with green background
  static void showSuccess({
    required String message,
    String? title,
    SnackPosition position = _defaultPosition,
    Duration duration = _defaultDuration,
  }) {
    final String resolvedTitle = title ?? 'success'.tr;

    GetxSuperSnackbar.showSuccess(
      message,
      title: resolvedTitle,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
      duration: duration,
    );
  }

  /// error - with red background
  static void showError({
    required String message,
    String? title,
    SnackPosition position = _defaultPosition,
    Duration duration = _defaultDuration,
  }) {
    final String resolvedTitle = title ?? 'error'.tr;

    GetxSuperSnackbar.showError(
      message,
      title: resolvedTitle,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
      duration: duration,
    );
  }

  /// warning - with yellow background
  static void showWarning({
    required String message,
    String? title,
    SnackPosition position = _defaultPosition,
    Duration duration = _defaultDuration,
  }) {
    final String resolvedTitle = title ?? 'warning'.tr;

    GetxSuperSnackbar.showWarning(
      message,
      title: resolvedTitle,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
      duration: duration,
    );
  }

  /// info - with blue background
  static void showInfo({
    required String message,
    String? title,
    SnackPosition position = _defaultPosition,
    Duration duration = _defaultDuration,
  }) {
    final String resolvedTitle = title ?? 'info'.tr;

    GetxSuperSnackbar.showInfo(
      message,
      title: resolvedTitle,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
      duration: duration,
    );
  }
}
