import 'package:fl_chart/fl_chart.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class IncomeChart extends StatelessWidget {
  final List<FlSpot> spots;
  final String? unit;
  final double aspectRatio;

  const IncomeChart({
    super.key,
    required this.spots,
    this.unit,
    this.aspectRatio = 2,
  });

  NumberFormat get _numberFmt => NumberFormat.decimalPattern();

  List<Color> get _gradientColors => [
    AppColors.primary,
    AppColors.primary.withValues(alpha: 0.55),
  ];
  Color get _lineColor => AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FIcons.chartColumnIncreasing,
                    size: 13,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'income'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Q1 – Q4',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: LineChart(_mainData()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: const Color(0xFF6B7280),
    );
    final label = _defaultBottomLabel(value.toInt());

    return SideTitleWidget(
      meta: meta,
      child: Text(label, style: style),
    );
  }

  String _defaultBottomLabel(int index) {
    return switch (index) {
      0 => 'JAN',
      1 => 'APR',
      2 => 'JUL',
      3 => 'OCT',
      _ => '',
    };
  }

  LineChartData _mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchCallback: (FlTouchEvent e, LineTouchResponse? r) {},
        getTouchedSpotIndicator: (barData, spots) {
          return spots.map((spot) {
            return TouchedSpotIndicatorData(
              FlLine(color: _lineColor, strokeWidth: 2),
              FlDotData(
                show: true,
                getDotPainter: (_, _, _, _) =>
                    FlDotCirclePainter(radius: 4, color: _lineColor),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (spots) => const Color(0xFF1F2937),
          tooltipBorderRadius: BorderRadius.circular(10),
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          getTooltipItems: (spots) {
            return spots.map((spot) {
              final y = spot.y;
              return LineTooltipItem(
                '${_numberFmt.format(y)}${unit ?? ''}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: null,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: const Color(0xFFF3F4F6), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      minX: spots
          .map((s) => s.x)
          .fold<double>(double.infinity, (p, n) => n < p ? n : p),
      maxX: spots
          .map((s) => s.x)
          .fold<double>(-double.infinity, (p, n) => n > p ? n : p),
      minY:
          spots
                  .map((s) => s.y)
                  .fold<double>(double.infinity, (p, n) => n < p ? n : p) <
              0
          ? spots
                .map((s) => s.y)
                .fold<double>(double.infinity, (p, n) => n < p ? n : p)
          : 0,
      maxY: spots
          .map((s) => s.y)
          .fold<double>(-double.infinity, (p, n) => n > p ? n : p),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          preventCurveOverShooting: true,
          gradient: LinearGradient(colors: _gradientColors),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 3,
              color: Colors.white,
              strokeColor: _lineColor,
              strokeWidth: 2,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.18),
                AppColors.primary.withValues(alpha: 0.01),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
