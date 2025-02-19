import 'package:calendar_mgmt_services_app/shared/components/cards/event_image.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/event_info.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/restaurant_card.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/weather_card.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, String> evento;

  const EventDetailsPage({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventImage(
              imageUrl: evento['imagem']!,
              title: evento['titulo']!,
            ),
            EventInfo(description: evento['descricao']!),
            const SizedBox(height: 20),
            const WeatherCard(
              temperature: '25°C',
              condition: 'Céu Limpo',
            ),
            const SizedBox(height: 16),
            const RestaurantCard(
              name: 'La Pasta',
              type: 'Italiano',
              address: 'Rua da Gastronomia, 123',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
