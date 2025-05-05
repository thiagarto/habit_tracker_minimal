// lib/screens/settings_page.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_minimal/screens/premium_page.dart';
import 'package:habit_tracker_minimal/screens/stats_page.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

/// 📋 Pantalla de configuración con opciones de Premium y limpieza de datos
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Ver estadísticas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StatsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🌟 Activar Premium (redirige a pantalla)
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('Activar Premium'),
            subtitle: const Text('Desbloquea hábitos ilimitados'),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumPage()),
              );

              if (result == true) {
                habitProvider.activatePremium();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Premium activado.')),
                );
              }
            },
          ),
          const Divider(),

          // 🧹 Borrar todos los datos
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Borrar todos los datos'),
            subtitle: const Text('Elimina todos los hábitos y preferencias guardadas'),
            onTap: () {
              showDialog<bool>(
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
              ).then((confirm) {
                if (confirm == true) {
                  habitProvider.clearAllData().then((_) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Todos los datos fueron eliminados.')),
                    );
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
