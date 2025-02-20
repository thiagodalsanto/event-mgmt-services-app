// ignore_for_file: avoid_print
import 'package:calendar_mgmt_services_app/providers/event_provider.dart';
import 'package:calendar_mgmt_services_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('users');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider())
      ],
      child: const MyApp(),
    ),
  );

  // try {
  //   final eventService = EventService();
  //   final weatherService = WeatherService();
  //   final restaurantService = RestaurantService();
  //   await GeoLocationService.requestPermission();
  //   List<Event> events;
  //   if (await GeoLocationService.userPermittedGeoLocation()) {
  //     events = await eventService.getEventsByGeoLocation();
  //   } else {
  //     print('Permissão de localização negada');
  //     final locations = await eventService.getLocationsByJson();
  //     final location =
  //         locations.firstWhere((location) => location.id == '585069bcee19ad271e9bbcef'); //Foz do iguaçu
  //     events = await eventService.getEventsByLocation(location);
  //   }

  //   for (var event in events) {
  //     event.toString();
  //     print(event);
  //     print('---');
  //   }

  //   final weather = await weatherService.getWeather(events[0].latitude, events[0].longitude);
  //   print('Weather: ${weather.toString()}');

  //   final restaurants =
  //       await restaurantService.getRestaurantsByCoordinates(events[0].latitude, events[0].longitude);
  //   for (var restaurant in restaurants) {
  //     print(restaurant.toString());
  //     print('---');
  //   }
  // } on Exception catch (e) {
  //   print('Erro ao buscar eventos: $e');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
