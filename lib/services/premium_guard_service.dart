// lib/services/premium_guard_service.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_minimal/providers/habit_provider.dart';
import 'package:habit_tracker_minimal/screens/premium_page.dart';
//import 'package:habit_tracker_minimal/services/message_service.dart';

class PremiumGuardService {
  /// Verifica si el usuario puede agregar otro hábito (según el modo Premium)
  static Future<bool> canAddHabit(BuildContext context, HabitProvider provider) async {
    final isLimitReached = !provider.isPremium && provider.habits.length >= 3;

    if (isLimitReached) {
      // ✅ Crear instancia del servicio (no usar static)
     // final messageService = MessageService();

            await Navigator.push(
               context,
              MaterialPageRoute(builder: (_) => const PremiumPage()),
            );

// Verificamos si ahora es Premium (por si activó)
if (provider.isPremium) return true;
return false;

    }

    return true;
  }
}
