class PartnerDetailModel {
  final DetailItemModel item;
  final DetailCategoryModel category;

  const PartnerDetailModel({
    required this.item,
    required this.category,
  });

  factory PartnerDetailModel.fromJson(Map<String, dynamic> json) {
    return PartnerDetailModel(
      item: DetailItemModel.fromJson(json['item'] ?? {}),
      category: DetailCategoryModel.fromJson(json['category'] ?? {}),
    );
  }
}

class DetailItemModel {
  final int id;
  final String name;
  final String slug;
  final int minPrice;
  final int maxPrice;
  final String description;
  final String updatedHuman;
  final String image;

  const DetailItemModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.minPrice,
    required this.maxPrice,
    required this.description,
    required this.updatedHuman,
    required this.image,
  });

  factory DetailItemModel.fromJson(Map<String, dynamic> json) {
    return DetailItemModel(
      id: _parseInt(json['id']),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      minPrice: _parseInt(json['min_price']),
      maxPrice: _parseInt(json['max_price']),
      description: json['description'] ?? '',
      updatedHuman: json['updated_human'] ?? '',
      image: json['image'] ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class DetailCategoryModel {
  final int id;
  final String name;
  final String slug;

  const DetailCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory DetailCategoryModel.fromJson(Map<String, dynamic> json) {
    return DetailCategoryModel(
      id: DetailItemModel._parseInt(json['id']),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}
