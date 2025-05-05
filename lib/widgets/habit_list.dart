// lib/widgets/habit_list.dart (corregido con verificación segura de día actual)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/habit_storage.dart';
import '../models/habit.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<HabitStorage>(context);

    // ✅ Corrección segura del día actual: lunes = 0, domingo = 6
    final raw = DateTime.now().weekday;
    final today = (raw == 7) ? 6 : raw - 1;

    // Días de la semana (mismo orden que completedDays)
    const dayNames = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    final currentDayName = dayNames[today];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.teal),
              const SizedBox(width: 8),
              Text(
                'Hábitos del $currentDayName',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: storage.habits.length,
            itemBuilder: (context, index) {
              final habit = storage.habits[index];

              // Seguridad: asegurar 7 días
              if (habit.completedDays.length != 7) {
                habit.completedDays = List.filled(7, false);
              }

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: List.generate(7, (dayIndex) {
                          final done = habit.completedDays[dayIndex];
                          debugPrint('Habit ${habit.name} - Día $dayIndex: $done');

                          return Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: done ? Colors.teal : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: habit.completedDays[today]
                        ? Colors.teal.shade100
                        : Colors.grey.shade200,
                    child: Icon(
                      habit.completedDays[today]
                          ? Icons.check
                          : Icons.circle_outlined,
                      color: habit.completedDays[today]
                          ? Colors.teal
                          : Colors.grey,
                    ),
                  ),
                  onTap: () => storage.toggleDay(index, today),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => storage.removeHabit(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
