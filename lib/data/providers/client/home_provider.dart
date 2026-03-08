import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/api_url.dart';
import 'package:dio/dio.dart';

class HomeProvider {
  final Dio _dio;

  HomeProvider({required Dio dio}) : _dio = dio;

  Future<dynamic> getHomeSummary() async {
    try {
      final response = await _dio.get(AppUrl.homeSummary);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getHomeBlogs() async {
    try {
      final response = await _dio.get(AppUrl.homeBlogs);
      return response.data;
    } catch (e) {
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getPartnerCategories() async {
    try {
      final response = await _dio.get(AppUrl.partnerCategories);
      return response.data;
    } catch (e) {
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getPartnerCategoryDetail(String slug) async {
    try {
      final response = await _dio.get(AppUrl.partnerCategoryDetail(slug));
      return response.data;
    } catch (e) {
      throw Exception('network_error'.tr);
    }
  }
}
