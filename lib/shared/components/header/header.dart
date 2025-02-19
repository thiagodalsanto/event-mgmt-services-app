import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onSettingsPressed;

  const Header({
    super.key,
    required this.title,
    required this.onSettingsPressed,
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
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }
}
