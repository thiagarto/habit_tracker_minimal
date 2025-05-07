// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_page.dart';
import 'providers/habit_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crea e inicializa el nuevo provider basado en manager + repository
  final habitProvider = HabitProvider();
  await habitProvider.init();

  runApp(
    ChangeNotifierProvider<HabitProvider>.value(
      value: habitProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Hábitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
