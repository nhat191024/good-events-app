# Data Layer Guide

This document explains how the Data Layer is structured in the project, following the **Clean Architecture** and **Repository Pattern**.

## Structure

The data flow is:
`View` -> `Controller` -> `Repository` -> `Provider` -> `API/DB`

## 1. Models

Models are Data Transfer Objects (DTOs). They must include `fromJson` and `toJson`.

```dart
class UserModel {
  final int id;
  final String email;

  UserModel({required this.id, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
  };
}
```

## 2. Providers

Providers handle raw network requests using `Dio`. They do **not** parse models, they return `Map<String, dynamic>` or `List`.

```dart
class AuthProvider {
  final ApiService _apiService;
  AuthProvider(this._apiService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiService.dio.post('/login', data: {'email': email, 'password': password});
    return response.data;
  }
}
```

## 3. Repositories

Repositories act as a bridge. They call Providers, handle exceptions, and return Domain Models.

**Interface (Domain Layer - `domain/repositories/`):**

```dart
abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
}
```

**Implementation (Data Layer - `data/repositories/`):**

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _provider; // Injected via GetX Binding
  AuthRepositoryImpl(this._provider);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final rawData = await _provider.login(email, password);
      return UserModel.fromJson(rawData);
    } catch (e) {
      // Log error and rethrow or handle custom exception
      rethrow;
    }
  }
}
```

## 4. Usage in Controller

Controllers use Repositories to get data. Do not call Providers directly in Controllers.

```dart
class LoginController extends GetxController {
  final AuthRepository _authRepository;

  // Repository is injected via constructor usually
  LoginController(this._authRepository);

  final isLoading = false.obs;

  Future<void> handleLogin() async {
    try {
      isLoading.value = true;
      final user = await _authRepository.login("test@gmail.com", "123456");
      // Handle success
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
```
