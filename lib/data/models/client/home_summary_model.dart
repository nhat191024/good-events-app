class HomeSummaryModel {
  final bool isHasNewNoti;
  final int pendingOrders;
  final int confirmedOrders;
  final int pendingPartners; // Applicants

  const HomeSummaryModel({
    required this.isHasNewNoti,
    required this.pendingOrders,
    required this.confirmedOrders,
    required this.pendingPartners,
  });

  factory HomeSummaryModel.fromJson(Map<String, dynamic> json) {
    return HomeSummaryModel(
      isHasNewNoti: json['is_has_new_noti'] ?? false,
      pendingOrders: _parseInt(json['pending_orders']),
      confirmedOrders: _parseInt(json['confirmed_orders']),
      pendingPartners: _parseInt(json['pending_partners']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
