import 'package:flutter/material.dart';

/// Tipo de repetición del hábito
enum Repetition {
  daily,
  weekly,
  customDays, // días específicos (ej: martes y jueves)
  monthly,    // mismo día cada mes
}

class Habit {
  final String name;
  List<bool> completedDays;
  final Repetition repetition;
  final List<int>? customDays; // 0 = lunes, 6 = domingo
  final TimeOfDay? reminderTime;
  final bool notificationsEnabled;

  Habit({
    required this.name,
    List<bool>? completedDays,
    this.repetition = Repetition.daily,
    this.customDays,
    this.reminderTime,
    this.notificationsEnabled = false,
  }) : completedDays = completedDays ?? List.filled(7, false);

  // ✅ Serialización
  Map<String, dynamic> toJson() => {
        'name': name,
        'completedDays': completedDays.map((e) => e ? 1 : 0).toList(),
        'repetition': repetition.name,
        'customDays': customDays,
        'reminderTime': reminderTime != null
            ? '${reminderTime!.hour}:${reminderTime!.minute}'
            : null,
        'notificationsEnabled': notificationsEnabled,
      };

  // ✅ Deserialización
  factory Habit.fromJson(Map<String, dynamic> json) {
    final raw = json['completedDays'] ?? [];
    final parsed = List<bool>.from((raw as List).map((e) => e == 1));

    final timeParts = (json['reminderTime'] as String?)?.split(':');
    final time = (timeParts != null && timeParts.length == 2)
        ? TimeOfDay(
            hour: int.tryParse(timeParts[0]) ?? 0,
            minute: int.tryParse(timeParts[1]) ?? 0,
          )
        : null;

    return Habit(
      name: json['name'],
      completedDays: parsed.length == 7 ? parsed : List.filled(7, false),
      repetition: Repetition.values.firstWhere(
        (e) => e.name == json['repetition'],
        orElse: () => Repetition.daily,
      ),
      customDays: json['customDays'] != null
          ? List<int>.from(json['customDays'])
          : null,
      reminderTime: time,
      notificationsEnabled: json['notificationsEnabled'] ?? false,
    );
  }
}
