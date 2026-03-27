import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/data/providers/auth_provider.dart';
import 'package:sukientotapp/domain/repositories/common/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final AuthProvider _authProvider;

  ForgotPasswordRepositoryImpl(this._authProvider);

  @override
  Future<bool> forgotPassword(String emailOrPhone) async {
    try {
      final response = await _authProvider.forgotPassword(emailOrPhone);
      final success = response['success'] as bool?;
      if (success == true) return true;
      final message = response['message'] as String?;
      if (message != null) throw Exception(message);
      return false;
    } catch (e) {
      logger.e('[ForgotPasswordRepositoryImpl] [forgotPassword] Failed: $e');
      rethrow;
    }
  }
}

