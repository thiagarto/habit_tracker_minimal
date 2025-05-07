import 'package:flutter/material.dart';
import 'package:habit_tracker_minimal/providers/habit_provider.dart';
import 'package:habit_tracker_minimal/screens/premium_page.dart';

class PremiumGuardService {
  static Future<bool> canAddHabit(BuildContext context, HabitProvider provider) async {
    final isLimitReached = !provider.isPremium && provider.habits.length >= 3;

    if (isLimitReached) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Límite alcanzado'),
          content: const Text(
            'Has alcanzado el límite de 3 hábitos en la versión gratuita.\n¿Querés activar Premium?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Ir a Premium'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumPage()),
        );

        if (result == true) {
          provider.activatePremium();
          return true;
        }
      }

      return false;
    }

    return true;
  }
}
