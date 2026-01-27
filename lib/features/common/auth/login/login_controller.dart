import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  final Logger _logger = Logger();

  LoginController(this._authRepository);

  final loginFormKey = GlobalKey<FormState>();

  var username = ''.obs;
  var password = ''.obs;

  final isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    username.close();
    password.close();
  }

  Future<void> login() async {
    loginFormKey.currentState!.save();

    if (!loginFormKey.currentState!.validate()) {
      debugPrint('Login form is invalid');
      return;
    }

    try {
      isLoading.value = true;
      _logger.i('[Auth] [Login] Attempting login for ${username.value}');

      final user = await _authRepository.login(username.value, password.value);

      _logger.i('[Auth] [Login] Login successful: ${user.name}');

      //TODO: Navigate to the next screen or save user info as needed
      Get.snackbar('Success', 'Login successful! Welcome, ${user.name}.');
    } catch (e) {
      _logger.e('[Auth] [Login] Login failed: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
