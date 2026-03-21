
import 'package:sukientotapp/data/providers/common/profile_provider.dart';
import 'package:sukientotapp/domain/repositories/common/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ProfileProvider _provider;

  ChangePasswordRepositoryImpl(this._provider);

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    await _provider.updatePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
