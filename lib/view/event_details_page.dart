import 'package:event_mgmt_services_app/features/event/models/event.dart';
import 'package:event_mgmt_services_app/features/restaurant/models/restaurant.dart';
import 'package:event_mgmt_services_app/features/restaurant/service/restaurant_service.dart';
import 'package:event_mgmt_services_app/features/weather/models/weather.dart';
import 'package:event_mgmt_services_app/features/weather/service/weather_service.dart';
import 'package:event_mgmt_services_app/providers/event_provider.dart';
import 'package:event_mgmt_services_app/shared/components/cards/event_image.dart';
import 'package:event_mgmt_services_app/shared/components/cards/event_info.dart';
import 'package:event_mgmt_services_app/shared/components/cards/restaurant_card.dart';
import 'package:event_mgmt_services_app/shared/components/cards/weather_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Weather? weather;
  Restaurant? restaurant;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      if (eventProvider.selectedEvent != null) {
        _fetchWeatherAndRestaurant(eventProvider.selectedEvent!);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> _fetchWeatherAndRestaurant(Event event) async {
    try {
      final weatherService = WeatherService();
      final restaurantService = RestaurantService();

      final fetchedWeather = await weatherService.getWeather(event.latitude, event.longitude);
      final fetchedRestaurants =
          await restaurantService.getRestaurantsByCoordinates(event.latitude, event.longitude);

      Restaurant? firstRestaurant;
      if (fetchedRestaurants.isNotEmpty) {
        firstRestaurant = fetchedRestaurants.first;
      }

      setState(() {
        weather = fetchedWeather;
        restaurant = firstRestaurant;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar informações: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final event = eventProvider.selectedEvent;

    if (event == null) {
      return Scaffold(
        body: Center(child: Text("Erro ao carregar o evento.")),
      );
    }

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
              imageUrl: event.thumbnail,
              title: event.title,
            ),
            EventInfo(
              description: event.address[0],
              eventDate: DateFormat('dd/MM/yyyy').format(event.date.start),
              eventLink: event.link,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : weather != null
                    ? WeatherCard(
                        temperature: '${weather!.temperature}°C',
                        sensation: '${weather!.feelsLike}',
                        condition: weather!.condition,
                      )
                    : const Center(child: Text("Previsão do tempo não disponível")),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : restaurant != null
                    ? RestaurantCard(
                        name: restaurant!.name,
                        type: restaurant!.categories.join(', '),
                        address: restaurant!.location.address,
                      )
                    : const Center(child: Text("Nenhum restaurante encontrado")),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
