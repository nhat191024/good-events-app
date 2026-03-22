import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class MyServicesProvider {
  final ApiService _apiService;
  MyServicesProvider(this._apiService);

  Future<List<Map<String, dynamic>>> getServices() async {
    try {
      final response = await _apiService.dio.get(AppUrl.partnerServices);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Failed to load services: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [getServices] DioException: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load services');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [getServices] Unknown error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getServiceDetail(String id) async {
    try {
      final response = await _apiService.dio.get(AppUrl.partnerServiceDetail(id));
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.first as Map<String, dynamic>;
      }
      throw Exception('Failed to load service detail: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [getServiceDetail] DioException: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load service detail');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [getServiceDetail] Unknown error: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getServiceCategories() async {
    try {
      final response = await _apiService.dio.get(AppUrl.partnerServiceCategories);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Failed to load categories: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [getServiceCategories] DioException: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load categories');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [getServiceCategories] Unknown error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createService(
    String categoryId,
    List<Map<String, dynamic>> mediaList,
  ) async {
    try {
      final body = <String, dynamic>{
        'category_id': int.parse(categoryId),
        if (mediaList.isNotEmpty) 'service_media': mediaList,
      };
      final response = await _apiService.dio.post(
        AppUrl.partnerServiceCreate,
        data: body,
      );
      if (response.statusCode == 201) {
        return response.data['data'] as Map<String, dynamic>;
      }
      throw Exception('Failed to create service: \${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [createService] DioException: \${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to create service');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [createService] Unknown error: $e');
      rethrow;
    }
  }

  Future<bool> updateService(String id, String categoryId) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.partnerServiceUpdate(id),
        data: {'category_id': int.parse(categoryId)},
      );
      if (response.statusCode == 200) {
        return response.data['success'] as bool? ?? true;
      }
      throw Exception('Failed to update service: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [updateService] DioException: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to update service');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [updateService] Unknown error: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getServiceImages(String serviceId) async {
    try {
      final response =
          await _apiService.dio.get(AppUrl.partnerServiceImages(serviceId));
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Failed to load images: \${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [getServiceImages] DioException: \${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load images');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [getServiceImages] Unknown error: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> uploadServiceImages(
    String serviceId,
    List<XFile> images,
  ) async {
    try {
      final formData = FormData();
      for (final xfile in images) {
        formData.files.add(MapEntry(
          'images[]',
          await MultipartFile.fromFile(xfile.path, filename: xfile.name),
        ));
      }
      final response = await _apiService.dio.post(
        AppUrl.partnerServiceImages(serviceId),
        data: formData,
      );
      if (response.statusCode == 201) {
        final data = response.data['data'] as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Failed to upload images: \${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [uploadServiceImages] DioException: \${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to upload images');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [uploadServiceImages] Unknown error: $e');
      rethrow;
    }
  }

  Future<bool> deleteServiceImage(String serviceId, String imageId) async {
    try {
      final response = await _apiService.dio.delete(
        AppUrl.partnerServiceDeleteImage(serviceId, imageId),
      );
      if (response.statusCode == 200) {
        return response.data['success'] as bool? ?? true;
      }
      throw Exception('Failed to delete image: \${response.statusCode}');
    } on DioException catch (e) {
      logger.e('[MyServicesProvider] [deleteServiceImage] DioException: \${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to delete image');
      }
      throw Exception('Cannot connect to server. Please check your connection.');
    } catch (e) {
      logger.e('[MyServicesProvider] [deleteServiceImage] Unknown error: $e');
      rethrow;
    }
  }
}
