import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_minimal/services/habit_dialog_service.dart';
import 'package:habit_tracker_minimal/services/message_service.dart';

void main() {
  setUpAll(() {
    MessageService.showCenterError = (context, message) {
      debugPrint('Mocked showCenterError: $message');
    };
  });

  tearDownAll(() {
    MessageService.resetDefaults();
  });

  group('HabitDialogService', () {
    testWidgets('debe devolver el nombre ingresado al presionar Agregar',
        (tester) async {
      String? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await HabitDialogService.requestHabitName(context);
              },
              child: const Text('Abrir diálogo'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir diálogo'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Leer 20 minutos');
      await tester.tap(find.text('Agregar'));
      await tester.pumpAndSettle();

      expect(result, 'Leer 20 minutos');
    });

    testWidgets('no debe cerrar si se ingresa texto vacío', (tester) async {
      String? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await HabitDialogService.requestHabitName(context);
              },
              child: const Text('Abrir diálogo'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir diálogo'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Agregar'));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(result, isNull);
    });

       testWidgets('debe devolver null al presionar Cancelar', (tester) async {
      String? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await HabitDialogService.requestHabitName(context);
              },
              child: const Text('Abrir diálogo'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir diálogo'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(result, isNull);
      expect(find.byType(AlertDialog), findsNothing);
    });


  });
}
