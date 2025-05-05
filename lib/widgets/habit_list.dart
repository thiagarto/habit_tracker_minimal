// lib/widgets/habit_list.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

/// 📋 Lista de hábitos con encabezado de día actual y visualización tipo GitHub
class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    // 📆 Determina el índice del día actual (lunes = 0, domingo = 6)
    final raw = DateTime.now().weekday;
    final today = (raw == 7) ? 6 : raw - 1;

    // 🗓️ Nombres de los días de la semana
    const dayNames = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
    ];
    final now = DateTime.now();
    final currentDayName = "${dayNames[today]} ${now.day}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔠 Título con el día actual
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

        const SizedBox(height: 12),

        // 📦 Lista de hábitos o mensaje si está vacía
        Expanded(
          child: habitProvider.habits.isEmpty
              ? const Center(
                  child: Text(
                    'Sin hábitos aún. Agrega uno para comenzar 📅',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: habitProvider.habits.length,
                  itemBuilder: (context, index) {
                    final habit = habitProvider.habits[index];

                    // 🛡️ Asegura que tenga 7 valores (uno por día)
                    if (habit.completedDays.length != 7) {
                      habit.completedDays = List.filled(7, false);
                    }

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),

                        // 🏷️ Título del hábito y mini gráfico de progreso
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),

                            // 🔳 Cuadros tipo GitHub para los 7 días
                            Wrap(
                              spacing: 4,
                              children: List.generate(7, (dayIndex) {
                                final done = habit.completedDays[dayIndex];
                                return Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: done
                                        ? Colors.teal
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),

                        // 🎯 Círculo de acción para marcar el día actual
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

                        // 📌 Tap para marcar/desmarcar el día de hoy
                        onTap: () => habitProvider.toggleDay(index, today),

                        // 🗑️ Eliminar hábito
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => habitProvider.removeHabit(index),
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
