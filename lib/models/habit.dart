// lib/models/habit.dart

import 'package:flutter/material.dart';

class Habit {
  final String name;
  List<bool> completedDays;
  final TimeOfDay? reminderTime;
  final bool notificationsEnabled;
  final Color? color; // NUEVO

  Habit({
    required this.name,
    List<bool>? completedDays,
    this.reminderTime,
    this.notificationsEnabled = false,
    this.color, // NUEVO
  }) : completedDays = completedDays ?? List.filled(7, false);

  Map<String, dynamic> toJson() => {
        'name': name,
        'completedDays': completedDays.map((e) => e ? 1 : 0).toList(),
        'reminderTime': reminderTime != null
            ? '${reminderTime!.hour}:${reminderTime!.minute}'
            : null,
        'notificationsEnabled': notificationsEnabled,
        'color': color?.value, // NUEVO
      };

  factory Habit.fromJson(Map<String, dynamic> json) {
    final raw = json['completedDays'] ?? [];
    final parsed = List<bool>.from((raw as List).map((e) => e == 1));

    final timeString = json['reminderTime'];
    TimeOfDay? parsedTime;
    if (timeString != null && timeString is String) {
      final parts = timeString.split(":");
      if (parts.length == 2) {
        parsedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 0,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    }

    final colorValue = json['color'];
    final parsedColor = colorValue is int ? Color(colorValue) : null;

    return Habit(
      name: json['name'],
      completedDays: parsed.length == 7 ? parsed : List.filled(7, false),
      reminderTime: parsedTime,
      notificationsEnabled: json['notificationsEnabled'] ?? false,
      color: parsedColor, // NUEVO
    );
  }
}
