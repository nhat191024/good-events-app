import 'package:dio/dio.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/public_profile_preview_model.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';
import 'package:sukientotapp/data/providers/common/profile_provider.dart';
import 'package:sukientotapp/domain/repositories/common/my_profile_repository.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  final ProfileProvider _provider;

  MyProfileRepositoryImpl(this._provider);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _provider.getProfile();
    final profileJson = response['profile'] as Map<String, dynamic>;
    logger.d('[MyProfileRepo] raw profile keys: ${profileJson.keys.toList()}');
    logger.d('[MyProfileRepo] video_url="${profileJson['video_url']}"');
    return ProfileModel.fromJson(profileJson);
  }

  @override
  Future<PublicProfilePreviewModel> getPublicProfilePreview(int userId) async {
    final response = await _provider.getPublicProfilePreview(userId);
    return PublicProfilePreviewModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateProfile(FormData data) async {
    final response = await _provider.updateProfile(data);
    return ProfileModel.fromJson(response['user'] as Map<String, dynamic>);
  }
}
