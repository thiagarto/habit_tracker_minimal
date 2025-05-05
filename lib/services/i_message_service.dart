// lib/services/i_message_service.dart
import 'package:flutter/widgets.dart';

abstract class IMessageService {
  void showCenterError(BuildContext context, String message);
  void showDialogLimitReached(BuildContext context, {required VoidCallback onActivatePremium});
}
