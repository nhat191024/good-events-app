import 'package:sukientotapp/data/models/client/home_summary_model.dart';
import 'package:sukientotapp/data/models/client/blog_home_model.dart';
import 'package:sukientotapp/data/models/client/partner_category_model.dart';
import 'package:sukientotapp/data/models/client/partner_detail_model.dart';

abstract class HomeRepository {
  Future<HomeSummaryModel> getHomeSummary();
  Future<List<BlogItemModel>> getHomeBlogs();
  Future<List<PartnerCategoryModel>> getPartnerCategories();
  Future<PartnerDetailModel> getPartnerCategoryDetail(String slug);
}
