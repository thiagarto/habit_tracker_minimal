import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class HabitRankingPanel extends StatelessWidget {
  const HabitRankingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);
    final habits = provider.habits;

    final rankedHabits = List.of(habits)
      ..sort((a, b) {
        final aCount = a.completedDays.where((d) => d).length;
        final bCount = b.completedDays.where((d) => d).length;
        return bCount.compareTo(aCount); // mayor primero
      });

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: rankedHabits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final habit = rankedHabits[index];
        final completados = habit.completedDays.where((d) => d).length;
        final porcentaje = (completados / 7 * 100).round();

        return Container(
          decoration: BoxDecoration(
            color: habit.color?.withOpacity(0.9) ?? Colors.teal.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Text(
                '#${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  habit.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '$porcentaje%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
