// lib/screens/stats_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../widgets/premium_stats_panel.dart';
import '../widgets/charts/monthly_progress_chart.dart';
import 'premium_page.dart';
import '../widgets/habit_ranking_panel.dart';


class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Semanal'),
    BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Mensual'),
    BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Ranking'),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);

    final List<Widget> pages = [
      const PremiumStatsPanel(),
      const MonthlyProgressChart(),
      const HabitRankingPanel(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: pages[_currentIndex],
          ),

          // 🚫 Overlay si no es Premium
          if (!provider.isPremium)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock, size: 60, color: Colors.white),
                      const SizedBox(height: 16),
                      const Text(
                        'Función Premium bloqueada',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.workspace_premium),
                        label: const Text('Activar Premium'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PremiumPage()),
                          );
                          if (result == true) {
                            provider.activatePremium();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
