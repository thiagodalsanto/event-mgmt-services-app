import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
