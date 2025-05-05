import 'package:flutter/material.dart';
//import 'package:habit_tracker_minimal/dev/test_home.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_page.dart';
import 'screens/settings_page.dart';
import 'services/habit_storage.dart';

void main() async {
  // Asegura que Flutter esté inicializado antes de usar async
  WidgetsFlutterBinding.ensureInitialized();

  // Crea una instancia del almacenamiento de hábitos y la inicializa
  final habitStorage = HabitStorage();
  await habitStorage.init();

  // Ejecuta la app y proporciona habitStorage a través de Provider
  runApp(
    ChangeNotifierProvider(
      create: (_) => habitStorage,
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
      debugShowCheckedModeBanner: false, // Oculta el banner DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), // Colores base
        useMaterial3: true, // Activa Material 3
        textTheme: GoogleFonts.ralewayTextTheme(), // Tipografía moderna
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      themeMode: ThemeMode.system, // Usa el tema del sistema (oscuro/claro)
      home: const HomePage(),
      //home: const TestHome(), // <- usar para pruebas

    );
  }
}
