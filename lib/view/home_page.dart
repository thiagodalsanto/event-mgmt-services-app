import 'package:calendar_mgmt_services_app/core/services/geo_location_service.dart';
import 'package:calendar_mgmt_services_app/features/event/models/event.dart';
import 'package:calendar_mgmt_services_app/features/event/models/event_location.dart';
import 'package:calendar_mgmt_services_app/features/event/service/event_service.dart';
import 'package:calendar_mgmt_services_app/providers/user_provider.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/current_location.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/event_card.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/main_event_card.dart';
import 'package:calendar_mgmt_services_app/shared/components/header/header.dart';
import 'package:calendar_mgmt_services_app/shared/components/textfields/location_search_bar.dart';
import 'package:calendar_mgmt_services_app/shared/components/texts/section_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<Event> events = [];
  bool isLoading = true;
  String currentLocationName = "";

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _searchFocusNode.unfocus();
  }

  Future<void> _fetchEvents({String? searchQuery}) async {
    try {
      final eventService = EventService();
      await GeoLocationService.requestPermission();
      Location? location;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final locations = await eventService.getLocationsByJson();
        location = locations.firstWhere(
          (loc) => loc.name.toLowerCase().contains(searchQuery.toLowerCase()),
          orElse: () => Location(
            id: '',
            name: '',
            latitude: 0.0,
            longitude: 0.0,
            canonicalName: '',
            countryCode: '',
            targetType: '',
            reach: 0,
          ),
        );
      } else if (await GeoLocationService.userPermittedGeoLocation()) {
        events = await eventService.getEventsByGeoLocation();
      } else {
        final locations = await eventService.getLocationsByJson();
        location = locations.firstWhere((loc) => loc.id == '585069abee19ad271e9b727d');
      }

      if (location != null && location.id.isNotEmpty) {
        events = await eventService.getEventsByLocation(location);
        currentLocationName = location.name;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar eventos: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    print(events);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: "Bem-vindo, ${user!.name}!",
                  onSettingsPressed: () {
                    Navigator.pushNamed(context, '/personal-data');
                  },
                ),
                const SizedBox(height: 20),
                LocationSearchBar(
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    onFieldSubmitted: (value) {
                      _fetchEvents(searchQuery: value);
                    }),
                const SizedBox(height: 10),
                CurrentLocation(location: currentLocationName),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : events.isNotEmpty
                        ? Expanded(
                            child: Column(
                              children: [
                                MainEventCard(
                                  titulo: events[0].title,
                                  imagem: events[0].thumbnail,
                                  onTap: () {
                                    Navigator.pushNamed(context, '/event-details', arguments: {
                                      'titulo': events[0].title,
                                      'descricao': events[0].date.when,
                                      'imagem': events[0].thumbnail,
                                      'endereco': events[0].address.join(', '),
                                      'link': events[0].link,
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                const SectionTitle(title: "Eventos Recomendados"),
                                Expanded(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: events.length - 1,
                                    itemBuilder: (context, index) {
                                      final evento = events[index + 1];
                                      return EventCard(
                                        titulo: evento.title,
                                        descricao: evento.date.when,
                                        imagem: evento.thumbnail,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/event-details',
                                            arguments: {
                                              'titulo': evento.title,
                                              'descricao': evento.date.when,
                                              'imagem': evento.thumbnail,
                                              'endereco': evento.address.join(', '),
                                              'link': evento.link,
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Nenhum evento encontrado",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
