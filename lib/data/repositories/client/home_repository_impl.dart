import 'package:sukientotapp/domain/repositories/client/home_repository.dart';
import 'package:sukientotapp/data/providers/client/home_provider.dart';
import 'package:sukientotapp/data/models/client/home_summary_model.dart';
import 'package:sukientotapp/data/models/client/blog_home_model.dart';
import 'package:sukientotapp/data/models/client/partner_category_model.dart';
import 'package:sukientotapp/data/models/client/partner_detail_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeProvider _provider;

  HomeRepositoryImpl(this._provider);

  @override
  Future<HomeSummaryModel> getHomeSummary() async {
    final data = await _provider.getHomeSummary();
    if (data is Map<String, dynamic>) {
      return HomeSummaryModel.fromJson(data);
    }
    throw Exception('Invalid data format');
  }

  @override
  Future<List<BlogItemModel>> getHomeBlogs() async {
    final data = await _provider.getHomeBlogs();
    if (data is Map<String, dynamic> && data['blogs'] is List) {
      return (data['blogs'] as List).map((json) => BlogItemModel.fromJson(json)).toList();
    }
    throw Exception('Invalid data format');
  }

  @override
  Future<List<PartnerCategoryModel>> getPartnerCategories() async {
    final data = await _provider.getPartnerCategories();
    if (data is List) {
      return data.map((json) => PartnerCategoryModel.fromJson(json)).toList();
    }
    throw Exception('Invalid data format');
  }

  @override
  Future<PartnerDetailModel> getPartnerCategoryDetail(String slug) async {
    final data = await _provider.getPartnerCategoryDetail(slug);
    if (data is Map<String, dynamic>) {
      return PartnerDetailModel.fromJson(data);
    }
    throw Exception('Invalid data format');
  }
}
