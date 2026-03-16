import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_super_snackbar/getx_super_snackbar.dart';

class AppSnackbar {
  AppSnackbar._();

  static const SnackPosition _defaultPosition = SnackPosition.BOTTOM;

  /// success - with green background
  static void showSuccess({
    required String message,
    String title = 'Thành công',
    SnackPosition position = _defaultPosition,
  }) {
    GetxSuperSnackbar.showSuccess(
      message,
      title: title,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
    );
  }

  /// error - with red background
  static void showError({
    required String message,
    String title = 'Đã xảy ra lỗi',
    SnackPosition position = _defaultPosition,
  }) {
    GetxSuperSnackbar.showError(
      message,
      title: title,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
    );
  }

  /// warning - with yellow background
  static void showWarning({
    required String message,
    String title = 'Cảnh báo',
    SnackPosition position = _defaultPosition,
  }) {
    GetxSuperSnackbar.showWarning(
      message,
      title: title,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
    );
  }

  /// info - with blue background
  static void showInfo({
    required String message,
    String title = 'Thông tin',
    SnackPosition position = _defaultPosition,
  }) {
    GetxSuperSnackbar.showInfo(
      message,
      title: title,
      snackPosition: position,
      isDismissible: true,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 12.0,
    );
  }
}
