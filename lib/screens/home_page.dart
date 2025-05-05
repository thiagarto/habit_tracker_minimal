// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_minimal/widgets/habit_list.dart';
import 'package:habit_tracker_minimal/widgets/add_habit_button.dart';
import 'package:habit_tracker_minimal/screens/settings_page.dart';
import 'package:habit_tracker_minimal/screens/stats_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 AppBar con título y botón de configuración
      appBar: AppBar(
        title: const Text('Mis Hábitos'),
        actions: [
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
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: HabitList(),
      ),

      // 🔹 Botones flotantes: estadísticas y agregar hábito
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         // ➕ Botón para agregar nuevo hábito
           const SizedBox(
      width: 56,
      height: 56,
      child:  AddHabitButton(),
      ),
                    const SizedBox(height: 15),
 Container(
      width: 56,
      height: 56,
      margin: const EdgeInsets.only(bottom: 12),
          // 📊 Botón para ver estadísticas
          child:FloatingActionButton(
  heroTag: 'stats',
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const StatsPage()),
  ),
 // backgroundColor: Colors.tealAccent,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  child: const Icon(Icons.bar_chart, color: Colors.black),
),



     
 )],
      ),
    );
  }
}
