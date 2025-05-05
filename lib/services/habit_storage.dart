// lib/services/habit_storage.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';

class HabitStorage extends ChangeNotifier {
  List<Habit> habits = []; // Lista de hábitos
  bool isPremium = false; // Estado del usuario
  DateTime? lastResetDate; // Fecha del último reinicio semanal

  // Inicializa datos desde almacenamiento local
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('habits');
    final premium = prefs.getBool('isPremium');
    final lastReset = prefs.getString('lastReset');

    if (saved != null) {
      final data = jsonDecode(saved) as List;
      habits = data.map((e) => Habit.fromJson(e)).toList();
    }

    isPremium = premium ?? false;
    if (lastReset != null) {
      lastResetDate = DateTime.tryParse(lastReset);
    }

    // Verificar si cambió la semana y reiniciar si es necesario
    final now = DateTime.now();
    if (lastResetDate == null || !_isSameWeek(now, lastResetDate!)) {
      _resetWeeklyProgress();
      lastResetDate = now;
      await prefs.setString('lastReset', now.toIso8601String());
    }

    notifyListeners();
  }

  // Agrega un hábito si no se superó el límite
  void addHabit(Habit habit) {
    if (!isPremium && habits.length >= 3) return;
    habits.add(habit);
    notifyListeners();
    save();
  }

  // Elimina un hábito
  void removeHabit(int index) {
    habits.removeAt(index);
    notifyListeners();
    save();
  }

  // Marca/desmarca el día actual
  void toggleDay(int habitIndex, int dayIndex) {
    if (habits[habitIndex].completedDays.length == 7) {
      habits[habitIndex].completedDays[dayIndex] =
          !habits[habitIndex].completedDays[dayIndex];
      notifyListeners();
      save();
    }
  }

  // Activa Premium
  void activatePremium() async {
    isPremium = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', true);
    notifyListeners();
  }

  // Guarda los datos
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'habits',
      jsonEncode(habits.map((h) => h.toJson()).toList()),
    );
  }

  // Limpia todos los datos
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    habits = [];
    isPremium = false;
    lastResetDate = null;
    notifyListeners();
  }

  // 🔁 Resetea todos los días de los hábitos
  void _resetWeeklyProgress() {
    for (var habit in habits) {
      habit.completedDays = List.filled(7, false);
    }
  }

  // Verifica si dos fechas están en la misma semana (lunes como inicio)
  bool _isSameWeek(DateTime a, DateTime b) {
    final aMonday = a.subtract(Duration(days: a.weekday - 1));
    final bMonday = b.subtract(Duration(days: b.weekday - 1));
    return aMonday.year == bMonday.year && aMonday.month == bMonday.month && aMonday.day == bMonday.day;
  }
}
