import 'package:sukientotapp/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle(String accessToken);
  Future<UserModel> registerClient(Map<String, dynamic> data);
  Future<UserModel> registerPartner(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> checkToken();
  Future<bool> logout();
}
