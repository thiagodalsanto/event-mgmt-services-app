import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

void showSuccessNotification(BuildContext context, message) {
  showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade600,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 28),
            const SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ).animate().fade(duration: 300.ms).slideY(begin: -0.5, end: 0),
    ),
    displayDuration: const Duration(seconds: 3),
  );
}
