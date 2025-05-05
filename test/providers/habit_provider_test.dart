import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_minimal/models/habit.dart';
import 'package:habit_tracker_minimal/providers/habit_provider.dart';
import 'package:habit_tracker_minimal/repositories/habit_repository.dart';

/// 🧪 Repositorio falso para pruebas: simula SharedPreferences
class FakeHabitRepository extends HabitRepository {
  List<Habit> _habits = [];
  bool _isPremium = false;
  DateTime? _resetDate;

  @override
  Future<void> saveHabits(List<Habit> habits, DateTime? lastResetDate) async {
    _habits = habits;
    _resetDate = lastResetDate;
  }

  @override
  Future<(List<Habit>, DateTime?)> loadHabits() async {
    return (_habits, _resetDate);
  }

  @override
  Future<void> setPremium(bool isPremium) async {
    _isPremium = isPremium;
  }

  @override
  Future<bool> loadPremium() async {
    return _isPremium;
  }

  @override
  Future<void> clearAllData() async {
    _habits = [];
    _isPremium = false;
    _resetDate = null;
  }
}

void main() {
  group('HabitProvider', () {
    late HabitProvider provider;
    late FakeHabitRepository fakeRepo;

    setUp(() async {
      fakeRepo = FakeHabitRepository();
      provider = HabitProvider.forTesting(fakeRepo);
      await provider.init();
    });

    test('agrega un hábito correctamente', () {
      provider.addHabit(Habit(name: 'Leer'));
      expect(provider.habits.length, 1);
      expect(provider.habits.first.name, 'Leer');
    });

    test('no permite agregar más de 3 hábitos si no es premium', () {
      provider.addHabit(Habit(name: '1'));
      provider.addHabit(Habit(name: '2'));
      provider.addHabit(Habit(name: '3'));
      provider.addHabit(Habit(name: '4')); // debería ignorarse

      expect(provider.habits.length, 3);
    });

    test('permite agregar más de 3 hábitos si es premium', () async {
      provider.activatePremium();
      provider.addHabit(Habit(name: '1'));
      provider.addHabit(Habit(name: '2'));
      provider.addHabit(Habit(name: '3'));
      provider.addHabit(Habit(name: '4')); // permitido ahora

      expect(provider.habits.length, 4);
    });

    test('elimina un hábito por índice', () {
      provider.addHabit(Habit(name: 'Ejercicio'));
      provider.addHabit(Habit(name: 'Estudio'));
      provider.removeHabit(0);

      expect(provider.habits.length, 1);
      expect(provider.habits.first.name, 'Estudio');
    });

    test('borra todos los datos correctamente', () async {
      provider.addHabit(Habit(name: 'Habito 1'));
      await provider.clearAllData();

      expect(provider.habits.isEmpty, true);
      expect(provider.isPremium, false);
    });
  });
}
