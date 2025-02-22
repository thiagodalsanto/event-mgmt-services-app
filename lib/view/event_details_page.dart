import 'package:event_mgmt_services_app/features/event/models/event.dart';
import 'package:event_mgmt_services_app/features/restaurant/models/restaurant.dart';
import 'package:event_mgmt_services_app/features/restaurant/service/restaurant_service.dart';
import 'package:event_mgmt_services_app/features/weather/models/weather.dart';
import 'package:event_mgmt_services_app/features/weather/service/weather_service.dart';
import 'package:event_mgmt_services_app/providers/event_provider.dart';
import 'package:event_mgmt_services_app/shared/components/cards/event_image.dart';
import 'package:event_mgmt_services_app/shared/components/cards/event_info.dart';
import 'package:event_mgmt_services_app/shared/components/cards/weather_card.dart';
import 'package:event_mgmt_services_app/shared/components/lists/restaurant_list_view.dart';
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
  List<Restaurant?>? restaurant;
  bool isLoadingRestaurants = true;
  bool isLoadingWeather = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      if (eventProvider.selectedEvent != null) {
        _fetchWeatherAndRestaurant(eventProvider.selectedEvent!);
      } else {
        setState(() {
          isLoadingRestaurants = false;
          isLoadingWeather = false;
        });
      }
    });
  }

  Future<void> _fetchWeatherAndRestaurant(Event event) async {
    try {
      final weatherService = WeatherService();
      final restaurantService = RestaurantService();

      final fetchedWeather = await weatherService.getWeather(event.latitude, event.longitude);
      setState(() {
        weather = fetchedWeather;
        isLoadingWeather = false;
      });

      final fetchedRestaurants = await restaurantService.getRestaurantsByCoordinates(event.latitude, event.longitude);

      List<Restaurant?>? firstRestaurant;
      if (fetchedRestaurants.isNotEmpty) {
        firstRestaurant = fetchedRestaurants;
      }

      setState(() {
        restaurant = firstRestaurant;
        isLoadingRestaurants = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar informações: $e");
      }
      setState(() {
        isLoadingWeather = false;
        isLoadingRestaurants = false;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventImage(imageUrl: event.thumbnail, title: event.title),
                    isLoadingRestaurants
                        ? SizedBox(
                            width: double.infinity,
                            height: 145,
                            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 145,
                            child: weather != null
                                ? WeatherCard(
                                    temperature: '${weather!.temperature}°C',
                                    sensation: '${weather!.feelsLike}',
                                    condition:
                                        '${weather!.description[0].toUpperCase()}${weather!.description.substring(1)}',
                                    realCondition: weather!.condition,
                                  )
                                : const Center(child: Text("Previsão do tempo não disponível")),
                          ),
                    EventInfo(
                      description: event.address[0],
                      eventDate: DateFormat('dd/MM/yyyy').format(event.date.start),
                      eventLink: event.link,
                    ),
                    const SizedBox(height: 20),
                    isLoadingRestaurants
                        ? SizedBox(
                            width: double.infinity,
                            height: 145,
                            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                          )
                        : restaurant != null
                            ? RestaurantListView(restaurants: restaurant)
                            : const Center(child: Text("Nenhum restaurante encontrado")),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
