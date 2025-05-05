import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_minimal/models/habit.dart';
import 'package:habit_tracker_minimal/managers/habit_manager.dart';

void main() {
  group('HabitManager', () {
    late HabitManager manager;

    setUp(() {
      manager = HabitManager();
    });

    test('agrega hábito si no es premium y hay menos de 3', () {
      manager.addHabit(Habit(name: 'A'));
      manager.addHabit(Habit(name: 'B'));
      manager.addHabit(Habit(name: 'C'));

      expect(manager.habits.length, 3);

      manager.addHabit(Habit(name: 'D')); // debería ser ignorado
      expect(manager.habits.length, 3);
    });

    test('agrega hábito sin límite si es premium', () {
      manager.activatePremium();

      manager.addHabit(Habit(name: '1'));
      manager.addHabit(Habit(name: '2'));
      manager.addHabit(Habit(name: '3'));
      manager.addHabit(Habit(name: '4'));

      expect(manager.habits.length, 4);
    });

    test('elimina un hábito por índice', () {
      manager.addHabit(Habit(name: 'Test'));
      expect(manager.habits.length, 1);

      manager.removeHabit(0);
      expect(manager.habits.isEmpty, true);
    });

    test('marca y desmarca un día correctamente', () {
      manager.addHabit(Habit(name: 'Correr'));

      expect(manager.habits.first.completedDays[1], false);
      manager.toggleDay(0, 1);
      expect(manager.habits.first.completedDays[1], true);

      manager.toggleDay(0, 1);
      expect(manager.habits.first.completedDays[1], false);
    });

    test('reinicia progreso semanal', () {
      manager.addHabit(Habit(name: 'Leer', completedDays: [true, true, true, true, true, true, true]));
      manager.resetWeeklyProgress();

      expect(manager.habits.first.completedDays.every((d) => d == false), true);
    });

    test('detecta correctamente semanas iguales', () {
      final lunes1 = DateTime(2024, 4, 1); // lunes
      final viernes1 = DateTime(2024, 4, 5); // viernes de la misma semana

      expect(manager.isSameWeek(lunes1, viernes1), true);
    });

    test('detecta correctamente semanas diferentes', () {
      final domingo = DateTime(2024, 4, 7); // domingo
      final lunesSiguiente = DateTime(2024, 4, 8); // siguiente lunes

      expect(manager.isSameWeek(domingo, lunesSiguiente), false);
    });
  });
}
