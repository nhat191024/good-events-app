import 'dart:convert';

class ProfileStatsModel {
  final int completedOrders;
  final String cancelledOrdersPct;

  const ProfileStatsModel({
    required this.completedOrders,
    required this.cancelledOrdersPct,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      completedOrders: json['completed_orders'] as int? ?? 0,
      cancelledOrdersPct: json['cancelled_orders_pct']?.toString() ?? '0',
    );
  }
}

class ProfileModel {
  final int id;
  final bool isLegit;
  final String avatarUrl;
  final String name;
  final String? partnerName;
  final String phone;
  final String email;
  final String bio;
  final String createdAt;
  final String location;
  final String videoUrl;
  final String? selfieImage;
  final String? identityCardNumber;
  final String? frontIdentityCardImage;
  final String? backIdentityCardImage;
  final int? locationId;
  final ProfileStatsModel stats;

  const ProfileModel({
    required this.id,
    required this.isLegit,
    required this.avatarUrl,
    required this.name,
    this.partnerName,
    required this.phone,
    required this.email,
    required this.bio,
    required this.createdAt,
    required this.location,
    required this.videoUrl,
    this.selfieImage,
    this.identityCardNumber,
    this.frontIdentityCardImage,
    this.backIdentityCardImage,
    this.locationId,
    required this.stats,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int? ?? 0,
      isLegit: json['is_legit'] as bool? ?? false,
      avatarUrl: json['avatar_url'] as String? ?? '',
      name: json['name'] as String? ?? '',
      partnerName: json['partner_name'] as String?,
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      location: json['location'] as String? ?? '',
      videoUrl: json['video_url'] as String? ?? '',
      selfieImage: json['selfie_image'] as String?,
      identityCardNumber: json['identity_card_number'] as String?,
      frontIdentityCardImage: json['front_identity_card_image'] as String?,
      backIdentityCardImage: json['back_identity_card_image'] as String?,
      locationId: json['location_id'] as int?,
      stats: ProfileStatsModel.fromJson(
        json['stats'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'is_legit': isLegit,
      'avatar_url': avatarUrl,
      'name': name,
      'partner_name': partnerName,
      'phone': phone,
      'email': email,
      'bio': bio,
      'created_at': createdAt,
      'location': location,
      'video_url': videoUrl,
      'selfie_image': selfieImage,
      'identity_card_number': identityCardNumber,
      'front_identity_card_image': frontIdentityCardImage,
      'back_identity_card_image': backIdentityCardImage,
      'location_id': locationId,
      'stats': {
        'completed_orders': stats.completedOrders,
        'cancelled_orders_pct': stats.cancelledOrdersPct,
      },
    };
  }

  String toJson() => json.encode(toMap());
}
