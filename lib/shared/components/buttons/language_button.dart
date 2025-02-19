import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;

  const LanguageButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "EN",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const VerticalDivider(color: Colors.black, thickness: 1),
            Text(
              "PT",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: !isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
