import 'package:sukientotapp/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle(String accessToken);
  Future<UserModel> loginWithApple({
    required String identityToken,
    required String authorizationCode,
    String? email,
    String? givenName,
    String? familyName,
  });
  Future<UserModel> registerClient(Map<String, dynamic> data);
  Future<UserModel> registerPartner(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> checkToken();
  Future<bool> logout();
  Future<void> sendOtp(String method);
  Future<void> verifyOtp(String otp);
  Future<void> forgotSendOtp({required String method, required String credential});
  Future<String> forgotVerifyOtp({required String phone, required String otp});
  Future<void> forgotResetPassword({
    required String resetToken,
    required String password,
  });
}
