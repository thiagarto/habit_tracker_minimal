import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../services/habit_dialog_service.dart';
import '../services/message_service.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final provider = Provider.of<HabitProvider>(context, listen: false);

        if (!provider.isPremium && provider.habits.length >= 3) {
          MessageService.showDialogLimitReached(context, onActivatePremium: () {
            provider.activatePremium();
          });
          return;
        }

        final name = await HabitDialogService.requestHabitName(context);
        if (name != null && name.trim().isNotEmpty) {
          provider.addHabit(Habit(name: name.trim()));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
