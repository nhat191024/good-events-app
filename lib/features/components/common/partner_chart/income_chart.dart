import 'package:fl_chart/fl_chart.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class IncomeChart extends StatelessWidget {
  final List<FlSpot> spots;
  final String? unit;
  final double aspectRatio;

  const IncomeChart({super.key, required this.spots, this.unit, this.aspectRatio = 2});

  NumberFormat get _numberFmt => NumberFormat.decimalPattern();

  List<Color> get _gradientColors => [AppColors.red800, AppColors.red400];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'income'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
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
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.black);
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
              FlLine(color: AppColors.red800, strokeWidth: 2),
              FlDotData(
                show: true,
                getDotPainter: (_, _, _, _) =>
                    FlDotCirclePainter(radius: 4, color: AppColors.red800),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (spots) => Colors.black.withValues(alpha: 0.8),
          tooltipBorderRadius: BorderRadius.circular(8),
          tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          getTooltipItems: (spots) {
            return spots.map((spot) {
              final y = spot.y;
              return LineTooltipItem(
                '${_numberFmt.format(y)}${unit ?? ''}',
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(show: true, drawVerticalLine: false, drawHorizontalLine: true),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: spots.map((s) => s.x).fold<double>(double.infinity, (p, n) => n < p ? n : p),
      maxX: spots.map((s) => s.x).fold<double>(-double.infinity, (p, n) => n > p ? n : p),
      minY: spots.map((s) => s.y).fold<double>(double.infinity, (p, n) => n < p ? n : p) < 0
          ? spots.map((s) => s.y).fold<double>(double.infinity, (p, n) => n < p ? n : p)
          : 0,
      maxY: spots.map((s) => s.y).fold<double>(-double.infinity, (p, n) => n > p ? n : p),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(colors: _gradientColors),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: _gradientColors.map((c) => c.withValues(alpha: 0.25)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
