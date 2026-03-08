class PartnerCategoryModel {
  final String id;
  final String name;
  final String image;
  final List<PartnerSubcategoryModel> partnerList;

  const PartnerCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.partnerList,
  });

  factory PartnerCategoryModel.fromJson(Map<String, dynamic> json) {
    var rawList = json['partnerList'] as List?;
    List<PartnerSubcategoryModel> parsedList = [];
    if (rawList != null) {
      parsedList = rawList.map((j) => PartnerSubcategoryModel.fromJson(j)).toList();
    }

    return PartnerCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      partnerList: parsedList,
    );
  }
}

class PartnerSubcategoryModel {
  final String id;
  final String name;
  final String slug;
  final String image;

  const PartnerSubcategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory PartnerSubcategoryModel.fromJson(Map<String, dynamic> json) {
    return PartnerSubcategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
