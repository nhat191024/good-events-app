class VoucherModel {
  final String code;
  final int discountPercent;
  final int maxDiscountAmount;
  final int minOrderAmount;
  final int? usageLimit;
  final int timesUsed;
  final bool isUnlimited;
  final String startsAt;
  final String expiresAt;

  VoucherModel({
    required this.code,
    required this.discountPercent,
    required this.maxDiscountAmount,
    required this.minOrderAmount,
    this.usageLimit,
    required this.timesUsed,
    required this.isUnlimited,
    required this.startsAt,
    required this.expiresAt,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      code: json['code'] as String? ?? '',
      discountPercent: json['discount_percent'] as int? ?? 0,
      maxDiscountAmount: json['max_discount_amount'] as int? ?? 0,
      minOrderAmount: json['min_order_amount'] as int? ?? 0,
      usageLimit: json['usage_limit'] as int?,
      timesUsed: json['times_used'] as int? ?? 0,
      isUnlimited: json['is_unlimited'] as bool? ?? false,
      startsAt: json['starts_at'] as String? ?? '',
      expiresAt: json['expires_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount_percent': discountPercent,
      'max_discount_amount': maxDiscountAmount,
      'min_order_amount': minOrderAmount,
      'usage_limit': usageLimit,
      'times_used': timesUsed,
      'is_unlimited': isUnlimited,
      'starts_at': startsAt,
      'expires_at': expiresAt,
    };
  }
}
