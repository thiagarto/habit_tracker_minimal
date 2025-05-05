import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker_minimal/models/habit.dart';
import 'package:habit_tracker_minimal/repositories/habit_repository.dart';

void main() {
  late HabitRepository repository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = HabitRepository();
  });

  test('guarda y carga hábitos correctamente', () async {
    final habits = [
      Habit(name: 'Leer', completedDays: [true, false, true, false, false, false, false]),
      Habit(name: 'Ejercicio'),
    ];

    await repository.saveHabits(habits, DateTime(2024, 5, 5));

    final (loadedHabits, resetDate) = await repository.loadHabits();

    expect(loadedHabits.length, 2);
    expect(loadedHabits.first.name, 'Leer');
    expect(loadedHabits.first.completedDays[0], true);
    expect(resetDate?.year, 2024);
  });

  test('guarda y carga estado premium', () async {
    await repository.setPremium(true);
    final loaded = await repository.loadPremium();
    expect(loaded, true);

    await repository.setPremium(false);
    final loaded2 = await repository.loadPremium();
    expect(loaded2, false);
  });

  test('borra todos los datos', () async {
    await repository.setPremium(true);
    await repository.saveHabits([Habit(name: 'X')], DateTime.now());

    await repository.clearAllData();

    final (loadedHabits, resetDate) = await repository.loadHabits();
    final premium = await repository.loadPremium();

    expect(loadedHabits, isEmpty);
    expect(resetDate, isNull);
    expect(premium, false);
  });
}
