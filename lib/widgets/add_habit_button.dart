import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/habit_storage.dart';
import '../models/habit.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<HabitStorage>(context);

    return FloatingActionButton(
      onPressed: () async {
        // Si el usuario no es premium y ya tiene 3 hábitos, mostrar alerta
        if (!storage.isPremium && storage.habits.length >= 3) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Límite alcanzado'),
              content: const Text(
                'Has alcanzado el límite de 3 hábitos en la versión gratuita. Activa Premium para agregar más hábitos.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    storage.activatePremium();
                    Navigator.pop(context);
                  },
                  child: const Text('Activar Premium'),
                ),
              ],
            ),
          );
          return;
        }

        // Mostrar diálogo para ingresar nombre del hábito
        final name = await showDialog<String>(
          context: context,
          builder: (context) {
            String tempName = '';
            return AlertDialog(
              title: const Text('Nuevo Hábito'),
              content: TextField(
                onChanged: (value) => tempName = value,
                decoration: const InputDecoration(hintText: 'Ej: Leer 15 minutos'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, tempName),
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );

        // Agrega el hábito si tiene nombre válido
        if (name != null && name.trim().isNotEmpty) {
          storage.addHabit(Habit(name: name.trim()));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
