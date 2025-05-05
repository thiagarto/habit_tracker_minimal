// lib/managers/habit_manager.dart

import '../models/habit.dart';

/// 🔄 Gestiona la lógica de negocio de los hábitos: agregar, quitar, marcar días, reiniciar semana.
class HabitManager {
  List<Habit> habits = [];
  bool isPremium = false;
  DateTime? lastResetDate;

  /// Agrega un hábito nuevo si no se supera el límite gratuito
  void addHabit(Habit habit) {
    if (!isPremium && habits.length >= 3) return;
    habits.add(habit);
  }

  /// Elimina un hábito por índice
  void removeHabit(int index) {
    habits.removeAt(index);
  }

  /// Marca o desmarca un día para un hábito dado
  void toggleDay(int habitIndex, int dayIndex) {
    final habit = habits[habitIndex];
    if (habit.completedDays.length != 7) return;
    habit.completedDays[dayIndex] = !habit.completedDays[dayIndex];
  }

  /// Reinicia el progreso semanal (pone todos los días en false)
  void resetWeeklyProgress() {
    for (var habit in habits) {
      habit.completedDays = List.filled(7, false);
    }
  }

  /// Verifica si dos fechas están en la misma semana (lunes como inicio)
  bool isSameWeek(DateTime a, DateTime b) {
    final aMonday = a.subtract(Duration(days: a.weekday - 1));
    final bMonday = b.subtract(Duration(days: b.weekday - 1));
    return aMonday.year == bMonday.year &&
        aMonday.month == bMonday.month &&
        aMonday.day == bMonday.day;
  }

  /// Activa modo premium (sin guardar directamente)
  void activatePremium() {
    isPremium = true;
  }
}
