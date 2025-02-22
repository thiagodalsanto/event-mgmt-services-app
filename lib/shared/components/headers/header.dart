import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onSettingsPressed;
  final VoidCallback onLogoutPressed;

  const Header({
    super.key,
    required this.title,
    required this.onSettingsPressed,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: onSettingsPressed,
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: onLogoutPressed,
            ),
          ],
        ),
      ],
    );
  }
}
