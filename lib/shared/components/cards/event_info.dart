import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  final String description;

  const EventInfo({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
