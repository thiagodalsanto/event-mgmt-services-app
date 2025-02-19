import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  final String location;

  const CurrentLocation({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.my_location, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(
          "Localização Atual: $location",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
