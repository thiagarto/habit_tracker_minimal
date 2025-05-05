import 'package:flutter/material.dart';

class MessageService {
  static void Function(BuildContext, String) showCenterError = _defaultCenterError;

@visibleForTesting
static void resetDefaults() {
  showCenterError = _defaultCenterError;
}


static void _defaultCenterError(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (_) => _CenteredFadeMessage(message: message),
  );
  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 3), () => entry.remove());
}


  static void showDialogLimitReached(BuildContext context, {required VoidCallback onActivatePremium}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Límite alcanzado'),
        content: const Text(
          'Has alcanzado el límite de 3 hábitos en la versión gratuita. Activa Premium para agregar más hábitos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              onActivatePremium();
              Navigator.pop(context);
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
          alignment: const Alignment(0, -0.2), // ⬇ más abajo del centro
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
