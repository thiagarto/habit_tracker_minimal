import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/habit_provider.dart';

class MonthlyProgressChart extends StatelessWidget {
  const MonthlyProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);
    final habits = provider.habits;

    // Inicializar 4 semanas
    final List<int> completadosPorSemana = List.filled(4, 0);
    final List<int> posiblesPorSemana = List.filled(4, 0);

    for (var habit in habits) {
      for (int i = 0; i < 7; i++) {
        final semana = i ~/ 2; // Simulación: días 0-1 -> semana 0, etc.
        if (semana < 4) {
          posiblesPorSemana[semana]++;
          if (habit.completedDays[i]) {
            completadosPorSemana[semana]++;
          }
        }
      }
    }

    List<BarChartGroupData> barras = List.generate(4, (i) {
      final completados = completadosPorSemana[i];
      final posibles = posiblesPorSemana[i].clamp(1, 100); // evitar división por 0
      final porcentaje = (completados / posibles) * 100;

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: porcentaje,
            width: 22,
            color: Colors.teal,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: barras,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                return Text('Semana ${value.toInt() + 1}');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, _) => Text('${value.toInt()}%'),
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
