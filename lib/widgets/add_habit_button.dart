import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../services/premium_guard_service.dart';
import 'habit_form_dialog.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final provider = Provider.of<HabitProvider>(context, listen: false);

        // ✅ Verifica límite Premium
        final canAdd = await PremiumGuardService.canAddHabit(context, provider);
        if (!canAdd) return;

        // 📋 Mostrar el formulario de hábito completo
        final habit = await showDialog<Habit>(
          context: context,
          builder: (_) => const HabitFormDialog(),
        );

        // ✅ Agregar si no es null
        if (habit != null) {
          provider.addHabit(habit);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
