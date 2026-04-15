import 'package:dio/dio.dart';
import 'package:sukientotapp/data/models/common/public_profile_preview_model.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';

abstract class MyProfileRepository {
  Future<ProfileModel> getProfile();
  Future<PublicProfilePreviewModel> getPublicProfilePreview(int userId);
  Future<ProfileModel> updateProfile(FormData data);
}
