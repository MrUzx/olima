import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    int durationSeconds = 3,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: Duration(seconds: durationSeconds),
        snackPosition: position,
      ),
    );
  }
}
