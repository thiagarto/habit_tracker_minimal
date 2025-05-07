// lib/controllers/habit_form_controller.dart

import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitFormController {
  final TextEditingController nameController = TextEditingController();
  TimeOfDay? reminderTime;
  bool notificationsEnabled = false;

  Color selectedColor = Colors.teal; // NUEVO

  Habit? submit() {
    final name = nameController.text.trim();
    if (name.isEmpty) return null;

    return Habit(
      name: name,
      reminderTime: notificationsEnabled ? reminderTime : null,
      notificationsEnabled: notificationsEnabled,
      color: selectedColor, // NUEVO
    );
  }

  void dispose() {
    nameController.dispose();
  }
}
