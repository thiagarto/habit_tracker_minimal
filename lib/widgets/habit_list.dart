// lib/widgets/habit_list.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
//import '../models/habit.dart';
import 'premium_habit_card.dart';
import '../theme.dart';

class HabitList extends StatelessWidget {
  final bool editMode;
  const HabitList({super.key, this.editMode = false});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final isPremium = habitProvider.isPremium;

    final raw = DateTime.now().weekday;
    final today = (raw == 7) ? 6 : raw - 1;

    const dayNames = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
    ];
    final now = DateTime.now();
    final currentDayName = "${dayNames[today]} ${now.day}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: mainColor),
              const SizedBox(width: 8),
              Text(
                'Hábitos del $currentDayName',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: habitProvider.habits.isEmpty
              ? const Center(
                  child: Text(
                    'Sin hábitos aún. Agrega uno para comenzar 🗕️',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 160),
                  itemCount: habitProvider.habits.length,
                  itemBuilder: (context, index) {
                    final habit = habitProvider.habits[index];

                    if (habit.completedDays.length != 7) {
                      habit.completedDays = List.filled(7, false);
                    }

                    return PremiumHabitCard(
                      habit: habit,
                      today: today,
                      editMode: editMode,
                      onToggleToday: () => habitProvider.toggleDay(index, today),
                      onToggleDay: (dayIndex) => habitProvider.toggleDay(index, dayIndex),
                      onDelete: () => habitProvider.removeHabit(index),
                    );
                  },
                ),
        ),
      ],
    );
  }
}