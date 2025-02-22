import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String sensation;
  final String condition;
  final String realCondition;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.sensation,
    required this.condition,
    required this.realCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Previsão do Tempo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temperatura Prevista: $temperature',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sensação: $sensation',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Condição: $condition',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  realCondition == 'Clouds'
                      ? Icons.cloud
                      : realCondition == 'Clear'
                          ? Icons.wb_sunny
                          : realCondition == 'Snow'
                              ? Icons.ac_unit
                              : realCondition == 'Rain'
                                  ? Icons.grain
                                  : realCondition == 'Drizzle'
                                      ? Icons.grain
                                      : realCondition == 'Thunderstorm'
                                          ? Icons.flash_on
                                          : Icons.error,
                  color: realCondition == 'Clouds'
                      ? Colors.grey
                      : realCondition == 'Clear'
                          ? Colors.orangeAccent
                          : realCondition == 'Snow'
                              ? Colors.lightBlue
                              : realCondition == 'Rain'
                                  ? Colors.blue
                                  : realCondition == 'Drizzle'
                                      ? Colors.blueAccent
                                      : realCondition == 'Thunderstorm'
                                          ? Colors.yellow
                                          : Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
