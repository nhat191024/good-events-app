import 'package:get_storage/get_storage.dart';
import 'package:sukientotapp/data/models/user_model.dart';
import 'package:sukientotapp/data/providers/auth_provider.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;
  final GetStorage _storage = GetStorage();

  AuthRepositoryImpl(this._authProvider);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      logger.i('[AuthRepositoryImpl] [login] Starting login process');

      final response = await _authProvider.login(email, password);

      final token = response['token'] as String?;
      if (token != null) {
        await _storage.write('token', token);
        logger.i('[AuthRepositoryImpl] [login] Token saved to storage');
      }

      final userData = response;
      final user = UserModel.fromJson(userData);

      logger.i('[AuthRepositoryImpl] [login] Login successful for user: ${user.email}');
      return user;
    } catch (e) {
      logger.e('[AuthRepositoryImpl] [login] Login failed: $e');
      rethrow;
    }
  }

  @override
  Future<bool> checkToken() async {
    try {
      logger.i('[AuthRepositoryImpl] [checkToken] Checking token validity');

      final isValid = await _authProvider.checkToken();

      if (isValid) {
        logger.i('[AuthRepositoryImpl] [checkToken] Token is valid');
      } else {
        logger.w('[AuthRepositoryImpl] [checkToken] Token is invalid or expired');
      }

      return isValid;
    } catch (e) {
      logger.e('[AuthRepositoryImpl] [checkToken] Check token failed: $e');
      rethrow;
    }
  }
}
