// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_minimal/widgets/habit_list.dart';
import 'package:habit_tracker_minimal/widgets/add_habit_button.dart';
import 'package:habit_tracker_minimal/screens/settings_page.dart';
import 'package:habit_tracker_minimal/screens/stats_page.dart';

// 🔧 Solo para desarrollador: habilita edición de cuadraditos
const bool kDebugEditSquares = true;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 AppBar con título, configuración y botón de edición (solo dev)
      appBar: AppBar(
        title: const Text('Mis Hábitos'),
        actions: [
          if (kDebugEditSquares)
            IconButton(
              icon: Icon(isEditMode ? Icons.edit_off : Icons.edit),
              tooltip: 'Editar Días',
              onPressed: () => setState(() => isEditMode = !isEditMode),
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
      ),

      // 🔹 Contenido principal: lista de hábitos
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HabitList(editMode: isEditMode),
      ),

      // 🔹 Botones flotantes: estadísticas y agregar hábito
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 56,
            height: 56,
            child: AddHabitButton(),
          ),
          const SizedBox(height: 15),
          Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.only(bottom: 12),
            child: FloatingActionButton(
              heroTag: 'stats',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StatsPage()),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.bar_chart, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
