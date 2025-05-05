// lib/widgets/habit_form_dialog.dart

import 'package:flutter/material.dart';
import '../controllers/habit_form_controller.dart';
import '../services/i_message_service.dart';
import '../services/message_service.dart'; // implementación concreta
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';


class HabitFormDialog extends StatefulWidget {
  const HabitFormDialog({super.key, this.messageService});

  final IMessageService? messageService;

  @override
  State<HabitFormDialog> createState() => _HabitFormDialogState();
}

class _HabitFormDialogState extends State<HabitFormDialog> {
  late final HabitFormController _controller;
  late final IMessageService _messageService;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = HabitFormController();
    _messageService = widget.messageService ?? MessageService();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final habit = _controller.submit();
    if (habit == null) {
      _messageService.showCenterError(context, 'Ingresa un nombre válido');
      return;
    }
    Navigator.pop(context, habit);
  }

 Future<void> _pickTime() async {
  final pickedTime = await showSpinnerTimePicker(
    context,
    initTime: _controller.reminderTime ?? TimeOfDay.now(),
    is24HourFormat: false,
    title: 'Selecciona una hora',
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    buttonTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
    barrierDismissible: true,
    buttonStyle: const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.teal),
    ),
  );

  if (pickedTime != null) {
    setState(() => _controller.reminderTime = pickedTime);
  }
}





  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo Hábito'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller.nameController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                labelText: 'Nombre del hábito',
                hintText: 'Ej: Meditar 10 minutos',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _controller.notificationsEnabled
                        ? Icons.alarm_on
                        : Icons.alarm_off,
                    color: _controller.notificationsEnabled
                        ? Colors.teal
                        : Colors.grey,
                  ),
                  onPressed: () => setState(() {
                    _controller.notificationsEnabled =
                        !_controller.notificationsEnabled;
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _controller.notificationsEnabled
                        ? (_controller.reminderTime != null
                            ? 'Recordatorio: ${_controller.reminderTime!.format(context)}'
                            : 'Selecciona una hora')
                        : 'Recordatorio desactivado',
                    style: TextStyle(
                      color: _controller.notificationsEnabled
                          ? Colors.teal
                          : Colors.grey,
                    ),
                  ),
                ),
                if (_controller.notificationsEnabled)
                  IconButton(
                    icon: const Icon(Icons.schedule),
                    color: Colors.teal,
                    onPressed: _pickTime,
                  ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
