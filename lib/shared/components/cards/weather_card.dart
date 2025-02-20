import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String sensation;
  final String condition;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.sensation,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Previsão do Tempo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Temperatura Prevista: $temperature', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('Sensação: $sensation', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('Condição: $condition', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
