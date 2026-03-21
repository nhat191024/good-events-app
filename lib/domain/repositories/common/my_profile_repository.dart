
import 'package:dio/dio.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';

abstract class MyProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(FormData data);
}

