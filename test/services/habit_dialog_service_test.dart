import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_minimal/services/habit_dialog_service.dart';
import 'package:habit_tracker_minimal/services/i_message_service.dart';

class FakeMessageService implements IMessageService {
  String? lastError;
  bool dialogShown = false;

  @override
  void showCenterError(BuildContext context, String message) {
    lastError = message;
  }

  @override
  void showDialogLimitReached(BuildContext context, {required VoidCallback onActivatePremium}) {
    dialogShown = true;
  }
}

void main() {
  late FakeMessageService fakeService;
  late HabitDialogService dialogService;

  setUp(() {
    fakeService = FakeMessageService();
    dialogService = HabitDialogService(messageService: fakeService);
  });

  testWidgets('Devuelve el nombre ingresado al presionar Agregar', (tester) async {
    String? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await dialogService.requestHabitName(context);
              },
              child: const Text('Abrir diálogo'),
            );
          },
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

  testWidgets('No cierra el diálogo si el nombre está vacío', (tester) async {
    String? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await dialogService.requestHabitName(context);
              },
              child: const Text('Abrir diálogo'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir diálogo'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Agregar'));
    await tester.pump(); // No settle, porque el diálogo debe seguir

    expect(result, isNull);
    expect(fakeService.lastError, 'Ingresa datos válidos');
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
