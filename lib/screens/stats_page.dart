// lib/screens/stats_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../widgets/premium_stats_panel.dart';
import '../widgets/charts/monthly_progress_chart.dart';
import 'premium_page.dart';

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

    if (!provider.isPremium) {
      Future.microtask(() async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumPage()),
        );
        if (result == true) {
          provider.activatePremium();
        } else {
          Navigator.pop(context);
        }
      });

      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔀 Selección de página según índice
    final List<Widget> pages = [
      const PremiumStatsPanel(),
      const MonthlyProgressChart(),
     const  Center(child: Text('🏆 Ranking de hábitos (pendiente)')),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
