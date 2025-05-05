import 'package:flutter/material.dart';
import 'i_message_service.dart';

class HabitDialogService {
  final IMessageService messageService;

  HabitDialogService({required this.messageService});

  Future<String?> requestHabitName(BuildContext context) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        bool submitted = false;

        void submit() {
          final name = controller.text.trim();
          if (name.isEmpty) {
            messageService.showCenterError(dialogContext, 'Ingresa datos válidos');
            return;
          }

          if (submitted) return;
          submitted = true;
          FocusScope.of(dialogContext).unfocus();

          Future.microtask(() {
            if (Navigator.of(dialogContext).canPop()) {
              Navigator.pop(dialogContext, name);
            }
          });
        }

        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(dialogContext).requestFocus(focusNode);
        });

        return AlertDialog(
          title: const Text('Nuevo Hábito'),
          content: TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => submit(),
            decoration: const InputDecoration(hintText: 'Ej: Leer 15 minutos'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
