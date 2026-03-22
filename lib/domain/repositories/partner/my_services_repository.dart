import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';

abstract class MyServicesRepository {
  Future<List<ServiceModel>> getServices();
  Future<ServiceDetailModel> getServiceDetail(String id);
  Future<List<ServiceCategoryModel>> getServiceCategories();
  Future<ServiceModel> createService(String categoryId, List<Map<String, dynamic>> media);
  Future<bool> updateService(String id, String categoryId);
  Future<List<ServiceImageModel>> getServiceImages(String serviceId);
  Future<List<ServiceImageModel>> uploadServiceImages(String serviceId, List<XFile> images);
  Future<bool> deleteServiceImage(String serviceId, String imageId);
}

