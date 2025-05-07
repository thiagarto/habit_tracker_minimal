// lib/widgets/premium_habit_card.dart

import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter/services.dart';

class PremiumHabitCard extends StatelessWidget {
  final Habit habit;
  final int today;
  final bool editMode;
  final VoidCallback onToggleToday;
  final VoidCallback onDelete;
  final void Function(int dayIndex) onToggleDay;

  const PremiumHabitCard({
    super.key,
    required this.habit,
    required this.today,
    required this.editMode,
    required this.onToggleToday,
    required this.onToggleDay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final completados = habit.completedDays.where((d) => d).length;
    final porcentaje = (completados / 7 * 100).round();
    final isTodayDone = habit.completedDays[today];

    final icon = habit.name.toLowerCase().contains('leer')
        ? Icons.menu_book
        : habit.name.toLowerCase().contains('meditar')
            ? Icons.self_improvement
            : Icons.star;

    final baseColor = habit.color ?? Colors.teal;

    final gradient = LinearGradient(
      colors: [
        baseColor.withOpacity(0.85),
        baseColor.withOpacity(1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: () {
HapticFeedback.mediumImpact();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: baseColor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: completados / 7,
                    strokeWidth: 6,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Text(
                  '$porcentaje%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 4,
                    children: List.generate(7, (i) {
                      final done = habit.completedDays[i];
                      final box = Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: done ? Colors.white : Colors.white38,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                      return editMode
                          ? GestureDetector(
                              onTap: () => onToggleDay(i),
                              child: box,
                            )
                          : box;
                    }),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(icon, color: Colors.white, size: 30),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: onToggleToday,
                  child: Icon(
                    isTodayDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
