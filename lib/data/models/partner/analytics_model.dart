class PartnerStatisticsModel {
  final int numberOfCustomers;
  final double satisfactionRate;
  final double revenue;
  final int ordersPlaced;
  final int completedOrders;
  final double cancellationRate;

  const PartnerStatisticsModel({
    required this.numberOfCustomers,
    required this.satisfactionRate,
    required this.revenue,
    required this.ordersPlaced,
    required this.completedOrders,
    required this.cancellationRate,
  });

  factory PartnerStatisticsModel.fromMap(Map<String, dynamic> map) {
    return PartnerStatisticsModel(
      numberOfCustomers: (map['number_of_customers'] as num).toInt(),
      satisfactionRate: (map['satisfaction_rate'] as num).toDouble(),
      revenue: (map['revenue'] as num).toDouble(),
      ordersPlaced: (map['orders_placed'] as num).toInt(),
      completedOrders: (map['completed_orders'] as num).toInt(),
      cancellationRate: (map['cancellation_rate'] as num).toDouble(),
    );
  }
}

class RevenueChartEntry {
  final String month;
  final String label;
  final double revenue;

  const RevenueChartEntry({
    required this.month,
    required this.label,
    required this.revenue,
  });

  factory RevenueChartEntry.fromMap(Map<String, dynamic> map) {
    return RevenueChartEntry(
      month: map['month'] as String,
      label: map['label'] as String,
      revenue: (map['revenue'] as num).toDouble(),
    );
  }
}

class TopServiceModel {
  final int id;
  final String name;
  final String slug;
  final int orderCount;
  final double totalRevenue;
  final String? latestOrder;

  const TopServiceModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.orderCount,
    required this.totalRevenue,
    this.latestOrder,
  });

  factory TopServiceModel.fromMap(Map<String, dynamic> map) {
    return TopServiceModel(
      id: (map['id'] as num).toInt(),
      name: map['name'] as String,
      slug: map['slug'] as String,
      orderCount: (map['order_count'] as num).toInt(),
      totalRevenue: (map['total_revenue'] as num).toDouble(),
      latestOrder: map['latest_order'] as String?,
    );
  }
}
