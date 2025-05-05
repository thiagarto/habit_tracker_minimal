// lib/services/message_service.dart

import 'package:flutter/material.dart';
import 'i_message_service.dart';

class MessageService implements IMessageService {
  static void Function(BuildContext, String) showCenterErrorFunc = _defaultCenterError;

  @visibleForTesting
  static void resetDefaults() {
    showCenterErrorFunc = _defaultCenterError;
  }

  @override
  void showCenterError(BuildContext context, String message) {
    showCenterErrorFunc(context, message);
  }

  static void _defaultCenterError(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => _CenteredFadeMessage(message: message),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () => entry.remove());
  }

  @override
  void showDialogLimitReached(BuildContext context, {required VoidCallback onActivatePremium}) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Límite alcanzado'),
        content: const Text(
          'Has alcanzado el límite de 3 hábitos en la versión gratuita. Activa Premium para agregar más hábitos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              onActivatePremium();
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Activar Premium'),
          ),
        ],
      ),
    );
  }
}

class _CenteredFadeMessage extends StatefulWidget {
  final String message;

  const _CenteredFadeMessage({required this.message});

  @override
  State<_CenteredFadeMessage> createState() => _CenteredFadeMessageState();
}

class _CenteredFadeMessageState extends State<_CenteredFadeMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Align(
          alignment: const Alignment(0, -0.2),
          child: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_fade),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
