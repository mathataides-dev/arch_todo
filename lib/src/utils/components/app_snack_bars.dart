import 'package:flutter/material.dart';

class AppSnackBars {
  static SnackBar successSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      showCloseIcon: true,
    );
  }

  static SnackBar errorSnackBar(Exception error) {
    return SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
      showCloseIcon: true,
    );
  }
}
