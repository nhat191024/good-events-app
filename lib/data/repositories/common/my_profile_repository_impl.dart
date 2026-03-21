import 'package:dio/dio.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';
import 'package:sukientotapp/data/providers/common/profile_provider.dart';
import 'package:sukientotapp/domain/repositories/common/my_profile_repository.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  final ProfileProvider _provider;

  MyProfileRepositoryImpl(this._provider);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _provider.getProfile();
    return ProfileModel.fromJson(response['profile'] as Map<String, dynamic>);
  }

  @override
  Future<ProfileModel> updateProfile(FormData data) async {
    final response = await _provider.updateProfile(data);
    return ProfileModel.fromJson(response['user'] as Map<String, dynamic>);
  }
}

