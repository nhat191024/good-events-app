import 'package:sukientotapp/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<bool> checkToken();
  Future<bool> logout();
}
