// lib/models/habit.dart

class Habit {
  final String name;
  List<bool> completedDays;

  Habit({required this.name, List<bool>? completedDays})
      : completedDays = completedDays ?? List.filled(7, false);

  // ✅ Serializa usando 1 y 0 para evitar errores con SharedPreferences
  Map<String, dynamic> toJson() => {
        'name': name,
        'completedDays': completedDays.map((e) => e ? 1 : 0).toList(),
      };

  // ✅ Deserializa usando 1 y 0 para reconstruir booleans correctamente
  factory Habit.fromJson(Map<String, dynamic> json) {
    final raw = json['completedDays'] ?? [];
    final parsed = List<bool>.from((raw as List).map((e) => e == 1));

    return Habit(
      name: json['name'],
      completedDays: parsed.length == 7 ? parsed : List.filled(7, false),
    );
  }
}
