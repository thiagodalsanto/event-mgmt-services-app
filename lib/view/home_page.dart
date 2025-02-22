import 'dart:convert';
import 'package:event_mgmt_services_app/features/event/models/event.dart';
import 'package:event_mgmt_services_app/features/event/models/event_location.dart';
import 'package:event_mgmt_services_app/features/event/service/event_service.dart';
import 'package:event_mgmt_services_app/providers/event_provider.dart';
import 'package:event_mgmt_services_app/providers/user_provider.dart';
import 'package:event_mgmt_services_app/routes/route_names.dart';
import 'package:event_mgmt_services_app/shared/components/cards/current_location.dart';
import 'package:event_mgmt_services_app/shared/components/cards/event_card.dart';
import 'package:event_mgmt_services_app/shared/components/cards/main_event_card.dart';
import 'package:event_mgmt_services_app/shared/components/headers/header.dart';
import 'package:event_mgmt_services_app/shared/components/textfields/location_search_bar.dart';
import 'package:event_mgmt_services_app/shared/components/texts/section_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<Event> events = [];
  List<String> locationSuggestions = [];
  bool isLoading = true;
  String currentLocationName = "";
  final EventService eventService = EventService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.isLoggedIn != true) {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    });
    _fetchEvents();
    _searchFocusNode.unfocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchEvents({String? searchQuery}) async {
    setState(() => isLoading = true);

    try {
      Location? location;
      final locations = await eventService.getLocationsByJson();

      if (searchQuery != null && searchQuery.isNotEmpty) {
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
              reach: 0),
        );
      } else {
        location = locations.firstWhere(
          (loc) => loc.id == '585069abee19ad271e9b727d',
          orElse: () => Location(
              id: '',
              name: '',
              latitude: 0.0,
              longitude: 0.0,
              canonicalName: '',
              countryCode: '',
              targetType: '',
              reach: 0),
        );
      }

      if (location.id.isNotEmpty) {
        events = await eventService.getEventsByLocation(location);
        currentLocationName = location.name;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar eventos: $e');
      }
    }

    setState(() => isLoading = false);
  }

  Future<void> _loadLocationSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() => locationSuggestions = []);
      return;
    }

    final String response = await rootBundle.loadString('lib/assets/locations_name.json');
    final List<dynamic> jsonData = json.decode(response);
    final List<String> allLocations = jsonData.cast<String>();

    final List<String> filteredLocations =
        allLocations.where((name) => name.toLowerCase().contains(query.toLowerCase())).take(5).toList();

    setState(() => locationSuggestions = filteredLocations);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
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
                  title: "Bem-vindo, ${user?.name}!",
                  onSettingsPressed: () {
                    _searchFocusNode.unfocus();
                    Navigator.pushNamed(context, RouteNames.personalData);
                  },
                  onLogoutPressed: () async {
                    await userProvider.logoutUser();
                    _searchFocusNode.unfocus();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  },
                ),
                const SizedBox(height: 20),
                LocationSearchBar(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  onFieldSubmitted: (value) => _fetchEvents(searchQuery: value),
                  onChanged: _loadLocationSuggestions,
                  locationSuggestions: locationSuggestions,
                  onSuggestionSelected: (location) {
                    _searchController.text = location;
                    _fetchEvents(searchQuery: location);
                    setState(() => locationSuggestions = []);
                  },
                ),
                const SizedBox(height: 10),
                CurrentLocation(location: currentLocationName),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : events.isNotEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainEventCard(
                                    titulo: events[0].title,
                                    imagem: events[0].thumbnail,
                                    onTap: () {
                                      final eventProvider = Provider.of<EventProvider>(context, listen: false);
                                      eventProvider.setSelectedEvent(events[0]);
                                      Navigator.pushNamed(context, '/event-details');
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  const SectionTitle(title: "Eventos Recomendados"),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: events.length - 1,
                                    itemBuilder: (context, index) {
                                      final evento = events[index + 1];
                                      return EventCard(
                                        titulo: evento.title,
                                        descricao: evento.date.when,
                                        imagem: evento.thumbnail,
                                        onTap: () {
                                          final eventProvider = Provider.of<EventProvider>(context, listen: false);
                                          eventProvider.setSelectedEvent(events[index + 1]);
                                          Navigator.pushNamed(context, '/event-details');
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
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
