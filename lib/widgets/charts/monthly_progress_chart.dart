// lib/widgets/charts/monthly_progress_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/habit_provider.dart';

/// 📈 Gráfico de línea mensual con cantidad de días real del mes.
/// El progreso total es proporcional a la cantidad de días cumplidos vs días del mes.
class MonthlyProgressChart extends StatelessWidget {
  const MonthlyProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    // 🔧 Por ahora todos los días valen 0%, para permitir edición manual
    final List<FlSpot> progressSpots = List.generate(
      daysInMonth,
      (i) => FlSpot((i + 1).toDouble(), 0),
    );

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (daysInMonth / 6).floorToDouble(),
              getTitlesWidget: (value, _) => Text('${value.toInt()}'),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 20,
              getTitlesWidget: (value, _) => Text('${value.toInt()}%'),
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: progressSpots,
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            belowBarData: BarAreaData(show: true, color: Colors.teal.withOpacity(0.3)),
            dotData: FlDotData(show: true),
          ),
        ],
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: const Border.symmetric(
            horizontal: BorderSide(color: Colors.black26),
            vertical: BorderSide(color: Colors.black26),
          ),
        ),
        minX: 1,
        maxX: daysInMonth.toDouble(),
        minY: 0,
        maxY: 100,
      ),
    );
  }
}
