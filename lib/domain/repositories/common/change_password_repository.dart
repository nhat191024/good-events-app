
abstract class ChangePasswordRepository {
  Future<void> updatePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  });
}
