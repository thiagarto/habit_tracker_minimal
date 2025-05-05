// lib/repositories/habit_repository.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';

/// 🗃️ Se encarga exclusivamente del acceso a datos (guardar, cargar, limpiar)
class HabitRepository {
  /// Guarda la lista de hábitos y la fecha del último reinicio
  Future<void> saveHabits(List<Habit> habits, DateTime? lastResetDate) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'habits',
      jsonEncode(habits.map((h) => h.toJson()).toList()),
    );

    if (lastResetDate != null) {
      prefs.setString('lastReset', lastResetDate.toIso8601String());
    }
  }

  /// Carga los hábitos y la fecha del último reinicio
  Future<(List<Habit>, DateTime?)> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('habits');
    final lastReset = prefs.getString('lastReset');

    List<Habit> habits = [];
    if (saved != null) {
      final data = jsonDecode(saved) as List;
      habits = data.map((e) => Habit.fromJson(e)).toList();
    }

    DateTime? resetDate =
        lastReset != null ? DateTime.tryParse(lastReset) : null;

    return (habits, resetDate);
  }

  /// Guarda el estado premium
  Future<void> setPremium(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPremium', isPremium);
  }

  /// Carga el estado premium
  Future<bool> loadPremium() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPremium') ?? false;
  }

  /// Borra todos los datos
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
