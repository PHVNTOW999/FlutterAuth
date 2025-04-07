import 'package:flutter/material.dart';

class Notificator {
  static void show(
      BuildContext context,
      String message, {
        Color? backgroundColor,
        Duration duration = const Duration(seconds: 3),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.grey[800],
        duration: duration,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.green);
  }

  static void error(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.red);
  }

  static void info(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.blue);
  }
}