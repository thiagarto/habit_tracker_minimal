import 'package:flutter/material.dart';
import '../widgets/habit_list.dart';
import '../screens/settings_page.dart';
import '../widgets/add_habit_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: HabitList(),
      ),
      floatingActionButton: const AddHabitButton(),
    );
  }
}
