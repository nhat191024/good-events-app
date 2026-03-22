import 'package:fl_chart/fl_chart.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/analytics_model.dart';
import 'controller.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text('revenue_statistics'.tr),
        prefixes: [FHeaderAction.back(onPress: () => Get.back())],
      ),
      child: Obx(() {
        if (controller.isLoading.value &&
            controller.statistics.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: false,
          header: const ClassicHeader(),
          onRefresh: controller.onRefresh,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RevenueChartSection(entries: controller.revenueChart),
                const SizedBox(height: 24),
                _StatisticsSection(stats: controller.statistics.value),
                const SizedBox(height: 24),
                _TopServicesSection(services: controller.topServices),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── Revenue Chart ────────────────────────────────────────────────────────────

class _RevenueChartSection extends StatelessWidget {
  final List<RevenueChartEntry> entries;

  const _RevenueChartSection({required this.entries});

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'monthly_revenue'.tr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.foreground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'last_12_months'.tr,
              style: TextStyle(
                fontSize: 12,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        'no_data'.tr,
                        style: TextStyle(
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                    )
                  : _buildChart(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final maxRevenue = entries.fold<double>(
      0,
      (prev, e) => e.revenue > prev ? e.revenue : prev,
    );
    final maxY = maxRevenue == 0 ? 1000000.0 : maxRevenue * 1.3;

    return BarChart(
      BarChartData(
        maxY: maxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final entry = entries[group.x];
              return BarTooltipItem(
                '${entry.label}\n${_formatRevenue(rod.toY)}',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= entries.length) {
                  return const SizedBox.shrink();
                }
                final parts = entries[index].label.split(' ');
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    parts.isNotEmpty ? parts[0] : '',
                    style: TextStyle(
                      fontSize: 9,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (value, meta) {
                if (value == 0) {
                  return const SizedBox.shrink();
                }
                return Text(
                  _formatRevenue(value),
                  style: TextStyle(
                    fontSize: 9,
                    color: context.fTheme.colors.mutedForeground,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: context.fTheme.colors.border.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(entries.length, (i) {
          final revenue = entries[i].revenue;
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: revenue,
                color: revenue > 0
                    ? context.fTheme.colors.primary
                    : context.fTheme.colors.border,
                width: 14,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatRevenue(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    }
    return value.toStringAsFixed(0);
  }
}

// ─── Statistics Section ───────────────────────────────────────────────────────

class _StatisticsSection extends StatelessWidget {
  final PartnerStatisticsModel? stats;

  const _StatisticsSection({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'overview'.tr,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: context.fTheme.colors.foreground,
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _StatCard(
              label: 'number_of_customers'.tr,
              value: '${stats?.numberOfCustomers ?? 0}',
              icon: Icons.people_outline_rounded,
              color: const Color(0xFF6366F1),
            ),
            _StatCard(
              label: 'satisfaction_rate'.tr,
              value: '${stats?.satisfactionRate.toStringAsFixed(1) ?? '0.0'}%',
              icon: Icons.thumb_up_alt_outlined,
              color: const Color(0xFF22C55E),
            ),
            _StatCard(
              label: 'revenue'.tr,
              value: _formatRevenue(stats?.revenue ?? 0),
              icon: Icons.account_balance_wallet_outlined,
              color: const Color(0xFFF59E0B),
            ),
            _StatCard(
              label: 'orders_processed'.tr,
              value: '${stats?.ordersPlaced ?? 0}',
              icon: Icons.receipt_long_outlined,
              color: const Color(0xFF3B82F6),
            ),
            _StatCard(
              label: 'completed_orders'.tr,
              value: '${stats?.completedOrders ?? 0}',
              icon: Icons.check_circle_outline_rounded,
              color: const Color(0xFF10B981),
            ),
            _StatCard(
              label: 'cancellation_rate'.tr,
              value: '${stats?.cancellationRate.toStringAsFixed(1) ?? '0.0'}%',
              icon: Icons.cancel_outlined,
              color: const Color(0xFFEF4444),
            ),
          ],
        ),
      ],
    );
  }

  String _formatRevenue(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B đ';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M đ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K đ';
    }
    return '${value.toStringAsFixed(0)} đ';
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.fTheme.colors.mutedForeground,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Top Services Section ─────────────────────────────────────────────────────

class _TopServicesSection extends StatelessWidget {
  final List<TopServiceModel> services;

  const _TopServicesSection({required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'top_services'.tr,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: context.fTheme.colors.foreground,
          ),
        ),
        const SizedBox(height: 12),
        FCard(
          child: services.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'no_data'.tr,
                      style: TextStyle(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    _TableHeader(context),
                    const Divider(height: 1),
                    ...List.generate(services.length, (i) {
                      return Column(
                        children: [
                          _ServiceRow(
                            rank: i + 1,
                            service: services[i],
                          ),
                          if (i < services.length - 1)
                            Divider(
                              height: 1,
                              color:
                                  context.fTheme.colors.border.withValues(alpha: 0.5),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _TableHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '#',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'service'.tr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              'orders'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'revenue'.tr,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final int rank;
  final TopServiceModel service;

  const _ServiceRow({required this.rank, required this.service});

  @override
  Widget build(BuildContext context) {
    final rankColors = [
      const Color(0xFFF59E0B),
      const Color(0xFF9CA3AF),
      const Color(0xFFB45309),
    ];
    final rankColor = rank <= 3
        ? rankColors[rank - 1]
        : context.fTheme.colors.mutedForeground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: rankColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.fTheme.colors.foreground,
                  ),
                ),
                if (service.latestOrder != null)
                  Text(
                    service.latestOrder!.substring(0, 10),
                    style: TextStyle(
                      fontSize: 10,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 56,
            child: Center(
              child: FBadge(
                style: FBadgeStyle.secondary(),
                child: Text(
                  '${service.orderCount}',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              _formatRevenue(service.totalRevenue),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.fTheme.colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatRevenue(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B đ';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M đ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K đ';
    }
    return '${value.toStringAsFixed(0)} đ';
  }
}
