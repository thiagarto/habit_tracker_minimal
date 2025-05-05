// lib/screens/premium_page.dart

import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mejorar a Premium'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Por qué mejorar a Premium?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.teal),
              title: Text('Hábitos ilimitados'),
              subtitle: Text('Agrega todos los hábitos que quieras sin límite.'),
            ),
            const ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.teal),
              title: Text('Estadísticas visuales'),
              subtitle: Text('Monitorea tu progreso con gráficos semanales.'),
            ),
            const ListTile(
              leading: Icon(Icons.auto_graph, color: Colors.teal),
              title: Text('Progreso mensual'),
              subtitle: Text('Descubre tus hábitos más cumplidos.'),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, true); // devuelve true para activar Premium
                },
                icon: const Icon(Icons.workspace_premium),
                label: const Text('Activar Premium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
