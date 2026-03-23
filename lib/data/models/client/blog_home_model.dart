class BlogItemModel {
  final String title;
  final String slug;
  final String type;
  final String publishedHuman;
  final int? maxPeople;
  final String? address;
  final String? thumbnail;
  final String? blogUrl;

  const BlogItemModel({
    required this.title,
    required this.slug,
    required this.type,
    required this.publishedHuman,
    this.maxPeople,
    this.address,
    this.thumbnail,
    this.blogUrl,
  });

  factory BlogItemModel.fromJson(Map<String, dynamic> json) {
    return BlogItemModel(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      type: json['type'] ?? '',
      publishedHuman: json['published_human'] ?? '',
      maxPeople: _parseIntOrNull(json['max_people']),
      address: json['address'],
      thumbnail: json['thumbnail'],
      blogUrl: json['blog_url'],
    );
  }

  static int? _parseIntOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
