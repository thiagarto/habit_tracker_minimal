// lib/widgets/premium_stats_panel.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
//import '../models/habit.dart';

class PremiumStatsPanel extends StatelessWidget {
  const PremiumStatsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);

    if (!provider.isPremium) {
      return const Center(
        child: Text(
          'Estadísticas Premium disponibles al activar Premium ✨',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final habits = provider.habits;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estadísticas Semanales',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...habits.map((habit) {
          final completados = habit.completedDays.where((d) => d).length;
          final porcentaje = (completados / 7 * 100).round();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: completados / 7,
                color: Colors.teal,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 4),
              Text('$porcentaje% completado esta semana'),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }
}
