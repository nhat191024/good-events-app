
import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';
import 'package:sukientotapp/data/providers/partner/my_services_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/my_services_repository.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class MyServicesRepositoryImpl implements MyServicesRepository {
  final MyServicesProvider _provider;
  MyServicesRepositoryImpl(this._provider);

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final raw = await _provider.getServices();
      return raw.map(ServiceModel.fromJson).toList();
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [getServices] $e');
      rethrow;
    }
  }

  @override
  Future<ServiceDetailModel> getServiceDetail(String id) async {
    try {
      final raw = await _provider.getServiceDetail(id);
      return ServiceDetailModel.fromJson(raw);
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [getServiceDetail] $e');
      rethrow;
    }
  }

  @override
  Future<List<ServiceCategoryModel>> getServiceCategories() async {
    try {
      final raw = await _provider.getServiceCategories();
      return raw.map(ServiceCategoryModel.fromJson).toList();
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [getServiceCategories] $e');
      rethrow;
    }
  }

  @override
  Future<ServiceModel> createService(
    String categoryId,
    List<Map<String, dynamic>> media,
  ) async {
    try {
      final raw = await _provider.createService(categoryId, media);
      return ServiceModel.fromJson(raw);
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [createService] $e');
      rethrow;
    }
  }

  @override
  Future<bool> updateService(String id, String categoryId) async {
    try {
      return await _provider.updateService(id, categoryId);
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [updateService] $e');
      rethrow;
    }
  }

  @override
  Future<List<ServiceImageModel>> getServiceImages(String serviceId) async {
    try {
      final raw = await _provider.getServiceImages(serviceId);
      return raw.map(ServiceImageModel.fromJson).toList();
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [getServiceImages] $e');
      rethrow;
    }
  }

  @override
  Future<List<ServiceImageModel>> uploadServiceImages(
    String serviceId,
    List<XFile> images,
  ) async {
    try {
      final raw = await _provider.uploadServiceImages(serviceId, images);
      return raw.map(ServiceImageModel.fromJson).toList();
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [uploadServiceImages] $e');
      rethrow;
    }
  }

  @override
  Future<bool> deleteServiceImage(String serviceId, String imageId) async {
    try {
      return await _provider.deleteServiceImage(serviceId, imageId);
    } catch (e) {
      logger.e('[MyServicesRepositoryImpl] [deleteServiceImage] $e');
      rethrow;
    }
  }
}

