class LocationModel {
  final int id;
  final String name;
  final String? code;
  final String? codename;
  final String? shortCodename;
  final int? parentId;

  LocationModel({
    required this.id,
    required this.name,
    this.code,
    this.codename,
    this.shortCodename,
    this.parentId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String?,
      codename: json['codename'] as String?,
      shortCodename: json['short_codename'] as String?,
      parentId: json['parent_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (code != null) 'code': code,
      if (codename != null) 'codename': codename,
      if (shortCodename != null) 'short_codename': shortCodename,
      if (parentId != null) 'parent_id': parentId,
    };
  }

  // Override equality for dropdown comparisons
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
