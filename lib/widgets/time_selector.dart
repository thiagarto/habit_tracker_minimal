import 'package:flutter/material.dart';

/// ⏰ Widget selector de hora para recordatorio de hábitos.
///
/// Permite al usuario elegir una hora usando `showTimePicker`.
/// Muestra el tiempo actual seleccionado o un texto si no hay ninguno.
class TimeSelector extends StatelessWidget {
  final TimeOfDay? time; // Hora actualmente seleccionada (nullable)
  final ValueChanged<TimeOfDay> onChanged; // Callback al cambiar la hora

  const TimeSelector({
    super.key,
    required this.time,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Texto que se muestra debajo del título
    final displayText = time != null
        ? time!.format(context)
        : 'Seleccionar hora';

    return ListTile(
      contentPadding: EdgeInsets.zero,

      // 🕒 Icono al inicio
      leading: const Icon(Icons.access_time),

      // 📝 Título del campo
      title: const Text('Recordatorio'),

      // 🔤 Hora seleccionada o texto por defecto
      subtitle: Text(displayText),

      // 📅 Acción al tocar el ListTile
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(), // Valor inicial
        );

        // Si el usuario seleccionó una hora válida
        if (picked != null) {
          onChanged(picked); // Notifica al componente padre
        }
      },
    );
  }
}
