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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RevenueHeroCard(stats: controller.statistics.value),
                const SizedBox(height: 20),
                _SectionLabel(label: 'monthly_revenue'.tr, sub: 'last_12_months'.tr),
                const SizedBox(height: 10),
                _RevenueChartSection(entries: controller.revenueChart),
                const SizedBox(height: 20),
                _SectionLabel(label: 'overview'.tr),
                const SizedBox(height: 10),
                _StatisticsSection(stats: controller.statistics.value),
                const SizedBox(height: 20),
                _SectionLabel(label: 'top_services'.tr),
                const SizedBox(height: 10),
                _TopServicesSection(services: controller.topServices),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  final String? sub;

  const _SectionLabel({required this.label, this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: context.fTheme.colors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: context.fTheme.colors.foreground,
          ),
        ),
        if (sub != null) ...[
          const SizedBox(width: 8),
          Text(
            sub!,
            style: TextStyle(
              fontSize: 11,
              color: context.fTheme.colors.mutedForeground,
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Revenue Hero Card ────────────────────────────────────────────────────────

class _RevenueHeroCard extends StatelessWidget {
  final PartnerStatisticsModel? stats;

  const _RevenueHeroCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.fTheme.colors.primary,
            context.fTheme.colors.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'revenue'.tr,
            style: TextStyle(
              fontSize: 13,
              color: context.fTheme.colors.primaryForeground.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _fmt(stats?.revenue ?? 0),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.primaryForeground,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _HeroStat(
                icon: Icons.people_outline_rounded,
                label: 'number_of_customers'.tr,
                value: '${stats?.numberOfCustomers ?? 0}',
              ),
              _HeroDivider(),
              _HeroStat(
                icon: Icons.receipt_long_outlined,
                label: 'orders_placed'.tr,
                value: '${stats?.ordersPlaced ?? 0}',
              ),
              _HeroDivider(),
              _HeroStat(
                icon: Icons.check_circle_outline_rounded,
                label: 'completed_orders'.tr,
                value: '${stats?.completedOrders ?? 0}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(double value) {
    if (value >= 1000000000) return '${(value / 1000000000).toStringAsFixed(1)}B đ';
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M đ';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K đ';
    return '${value.toStringAsFixed(0)} đ';
  }
}

class _HeroDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: context.fTheme.colors.primaryForeground.withValues(alpha: 0.25),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HeroStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 13,
            color: context.fTheme.colors.primaryForeground.withValues(alpha: 0.75),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.primaryForeground,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: context.fTheme.colors.primaryForeground.withValues(alpha: 0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Revenue Chart ────────────────────────────────────────────────────────────

class _RevenueChartSection extends StatelessWidget {
  final List<RevenueChartEntry> entries;

  const _RevenueChartSection({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 8),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.fTheme.colors.border),
      ),
      child: SizedBox(
        height: 180,
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
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
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
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: context.fTheme.colors.border.withValues(alpha: 0.4),
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
                gradient: revenue > 0
                    ? LinearGradient(
                        colors: [
                          context.fTheme.colors.primary,
                          context.fTheme.colors.primary.withValues(alpha: 0.55),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: revenue > 0 ? null : context.fTheme.colors.border,
                width: 16,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatRevenue(double value) {
    if (value >= 1000000000) return '${(value / 1000000000).toStringAsFixed(1)}B';
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }
}

// ─── Statistics Section ───────────────────────────────────────────────────────

class _StatisticsSection extends StatelessWidget {
  final PartnerStatisticsModel? stats;

  const _StatisticsSection({required this.stats});

  @override
  Widget build(BuildContext context) {
    final cells = [
      _StatCellData(
        icon: Icons.thumb_up_alt_outlined,
        color: const Color(0xFF22C55E),
        label: 'satisfaction_rate'.tr,
        value: '${stats?.satisfactionRate.toStringAsFixed(1) ?? '0.0'}%',
      ),
      _StatCellData(
        icon: Icons.cancel_outlined,
        color: const Color(0xFFEF4444),
        label: 'cancellation_rate'.tr,
        value: '${stats?.cancellationRate.toStringAsFixed(1) ?? '0.0'}%',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.fTheme.colors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _StatPanelCell(data: cells[0])),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: context.fTheme.colors.border,
            ),
            Expanded(child: _StatPanelCell(data: cells[1])),
          ],
        ),
      ),
    );
  }
}

class _StatCellData {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatCellData({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });
}

class _StatPanelCell extends StatelessWidget {
  final _StatCellData data;

  const _StatPanelCell({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, size: 18, color: data.color),
          ),
          const SizedBox(height: 10),
          Text(
            data.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.foreground,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.label,
            style: TextStyle(
              fontSize: 12,
              color: context.fTheme.colors.mutedForeground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
    if (services.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.fTheme.colors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.fTheme.colors.border),
        ),
        child: Center(
          child: Text(
            'no_data'.tr,
            style: TextStyle(color: context.fTheme.colors.mutedForeground),
          ),
        ),
      );
    }

    final maxCount = services.fold<int>(
      0,
      (prev, s) => s.orderCount > prev ? s.orderCount : prev,
    );

    return Column(
      children: List.generate(services.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < services.length - 1 ? 10 : 0),
          child: _ServiceTile(
            rank: i + 1,
            service: services[i],
            maxCount: maxCount,
          ),
        );
      }),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final int rank;
  final TopServiceModel service;
  final int maxCount;

  const _ServiceTile({
    required this.rank,
    required this.service,
    required this.maxCount,
  });

  static const _rankColors = [
    Color(0xFFF59E0B),
    Color(0xFF9CA3AF),
    Color(0xFFB45309),
  ];

  @override
  Widget build(BuildContext context) {
    final rankColor = rank <= 3
        ? _rankColors[rank - 1]
        : context.fTheme.colors.mutedForeground;
    final progress = maxCount > 0 ? service.orderCount / maxCount : 0.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.fTheme.colors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: rankColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        service.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.foreground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _fmt(service.totalRevenue),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: context.fTheme.colors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: context.fTheme.colors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(rankColor),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${service.orderCount} ${'orders'.tr}',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                    if (service.latestOrder != null)
                      Text(
                        service.latestOrder!.substring(0, 10),
                        style: TextStyle(
                          fontSize: 11,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(double value) {
    if (value >= 1000000000) return '${(value / 1000000000).toStringAsFixed(1)}B đ';
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M đ';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K đ';
    return '${value.toStringAsFixed(0)} đ';
  }
}
