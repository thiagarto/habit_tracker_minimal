import 'dart:math'; // arriba del archivo
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/habit_storage.dart';
import '../models/habit.dart';
import '../widgets/habit_list.dart'; // ✅ Importa la lista modular
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<HabitStorage>(context); // Accede al estado de hábitos

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Hábitos'),
        actions: [
          // ⚙️ Botón que abre la pantalla de configuración
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
      ),

      // ✅ Cuerpo de la pantalla: separamos en el widget HabitList
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: HabitList(), // Mostrará título con día + hábitos + progreso semanal
      ),

      // ➕ Botón flotante para agregar nuevo hábito
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final storage = Provider.of<HabitStorage>(context, listen: false);

          // 🛑 Límite para versión gratuita
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

          // 📝 Diálogo de ingreso de nombre
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

          // ✅ Si el nombre está vacío, usar 'Debug'
          final habitName = (name == null || name.trim().isEmpty) ? 'Debug' : name.trim();
          final completedDays = [true, true, true, true, true, true, true];
          debugPrint('Agregando hábito: $habitName con días $completedDays');

          storage.addHabit(Habit(
            name: habitName,
            completedDays: completedDays,
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
