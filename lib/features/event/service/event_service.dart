import 'package:event_mgmt_services_app/core/services/geo_location_service.dart';
import 'package:event_mgmt_services_app/features/event/models/event.dart';
import 'package:event_mgmt_services_app/features/event/data/event_api.dart';
import 'package:event_mgmt_services_app/features/event/enum/event_filter.dart';
import 'package:event_mgmt_services_app/features/event/models/event_location.dart';
import 'package:event_mgmt_services_app/features/google/data/google_api.dart';
import 'package:event_mgmt_services_app/features/google/data/google_maps.dart';

class EventService {
  late EventApi _eventApi;
  late GoogleApi _googleApi;

  EventService() {
    _eventApi = EventApi();
    _googleApi = GoogleApi();
  }

  Future<List<Event>> getEventsByCoordinates(double latitude, double longitude,
      {List<EventFilter>? filters}) async {
    GoogleMaps maps = await _googleApi.getLocationByCoordinates(latitude, longitude);
    final location = await _eventApi.getLocation(maps.getLocation());
    final events = await _eventApi.getEventsByLocation(location, filters: filters);
    return events;
  }

  Future<List<Event>> getEventsByGeoLocation() {
    return GeoLocationService.getCurrentLocation().then((position) {
      return getEventsByCoordinates(position.latitude, position.longitude);
    });
  }

  Future<List<Event>> getEventsByLocation(Location location, {List<EventFilter>? filters}) async {
    final events = await _eventApi.getEventsByLocation(location, filters: filters);
    return events;
  }

  Future<List<Location>> getLocations(String location) async {
    final locations = await _eventApi.getLocationList(location);
    return locations;
  }

  Future<List<Location>> getLocationsByJson() async {
    return await _eventApi.getLocationListByJson();
  }
}
