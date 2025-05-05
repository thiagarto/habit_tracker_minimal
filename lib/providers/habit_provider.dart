// lib/providers/habit_provider.dart

import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../managers/habit_manager.dart';
import '../repositories/habit_repository.dart';

/// 📊 Proveedor central que expone los datos y lógica al UI, usando HabitManager internamente.
class HabitProvider extends ChangeNotifier {
  final HabitManager _manager = HabitManager();
  final HabitRepository _repository = HabitRepository();

  List<Habit> get habits => _manager.habits;
  bool get isPremium => _manager.isPremium;

  /// Inicializa los datos desde almacenamiento local
  Future<void> init() async {
    final (loadedHabits, resetDate) = await _repository.loadHabits();
    final premium = await _repository.loadPremium();

    _manager.habits = loadedHabits;
    _manager.lastResetDate = resetDate;
    _manager.isPremium = premium;

    // Reinicia semana si es necesario
    final now = DateTime.now();
    if (resetDate == null || !_manager.isSameWeek(now, resetDate)) {
      _manager.resetWeeklyProgress();
      _manager.lastResetDate = now;
      await _repository.saveHabits(_manager.habits, now);
    }

    notifyListeners();
  }

  /// Agrega un hábito y guarda
  void addHabit(Habit habit) {
    _manager.addHabit(habit);
    _save();
  }

  /// Elimina un hábito y guarda
  void removeHabit(int index) {
    _manager.removeHabit(index);
    _save();
  }

  /// Marca o desmarca un día del hábito y guarda
  void toggleDay(int habitIndex, int dayIndex) {
    _manager.toggleDay(habitIndex, dayIndex);
    _save();
  }

  /// Activa Premium y guarda
  void activatePremium() async {
    _manager.activatePremium();
    await _repository.setPremium(true);
    notifyListeners();
  }

  /// Borra todos los datos (hábitos y premium)
  Future<void> clearAllData() async {
    await _repository.clearAllData();
    _manager.habits = [];
    _manager.isPremium = false;
    _manager.lastResetDate = null;
    notifyListeners();
  }

  /// Guarda estado completo en disco
  void _save() async {
    await _repository.saveHabits(_manager.habits, _manager.lastResetDate);
    notifyListeners();
  }
}
