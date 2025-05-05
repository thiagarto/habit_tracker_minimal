// lib/screens/settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/habit_storage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<HabitStorage>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('Activar Premium'),
            subtitle: const Text('Desbloquea hábitos ilimitados'),
            onTap: () async {
              storage.activatePremium();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Premium activado.')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Borrar todos los datos'),
            subtitle: const Text('Elimina todos los hábitos y preferencias guardadas'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('¿Estás seguro?'),
                  content: const Text('Esta acción eliminará todos tus datos guardados.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sí, borrar todo'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await storage.clearAllData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Todos los datos fueron eliminados.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
