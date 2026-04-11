class UserModel {
  final String role;
  final int id;
  final String email;
  final String name;
  final String phone;
  final String countryCode;
  final String avatarUrl;
  final String bio;
  final int walletBalance;
  final bool isHavePartnerProfile;
  final bool isLegit;

  UserModel({
    required this.role,
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.avatarUrl,
    this.bio = '',
    required this.walletBalance,
    required this.isHavePartnerProfile,
    required this.isLegit,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      role: json['role'] as String,
      id: json['user']['id'] as int,
      email: json['user']['email'] as String,
      name: json['user']['name'] as String,
      phone: json['user']['phone'] as String,
      countryCode: json['user']['country_code'] as String,
      avatarUrl: json['user']['avatar'] as String,
      bio: json['user']['bio'] as String? ?? '',
      walletBalance: json['user']['wallet_balance'] as int? ?? 0,
      isHavePartnerProfile:
          json['user']['is_have_partner_profile'] as bool? ?? false,
      isLegit: json['user']['is_legit'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'country_code': countryCode,
      'avatar_url': avatarUrl,
      'bio': bio,
      'wallet_balance': walletBalance,
      'is_have_partner_profile': isHavePartnerProfile,
      'is_legit': isLegit,
    };
  }
}
