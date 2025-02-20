import 'dart:convert';

import 'package:event_mgmt_services_app/features/event/enum/event_filter.dart';
import 'package:event_mgmt_services_app/features/event/models/event_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../models/event.dart';

class EventApi {
  static const String _baseUrl = 'https://serpapi.com';

  static const String _apiKey = '13415bf45b4ac899f2809594ebd18215d678b95ddebd1377c2b13038abd38671';

  final Dio dio = Dio();

  EventApi() {
    dio.options.baseUrl = _baseUrl;
  }

  Future<List<Event>> getEventsByLocation(Location location, {List<EventFilter>? filters}) async {
    final params = {
      'q': 'events',
      'google_domain': 'google.com',
      'api_key': _apiKey,
      'location': location.id,
      'engine': 'google_events',
      'htichips': filters?.map((filter) => filter.value).join(','),
    };

    final url = '$_baseUrl/search.json';

    try {
      final response = await dio.get(url, queryParameters: params);

      if (response.statusCode == 200) {
        final data = response.data['events_results'] as List;
        return data.map((event) {
          final eventObj = Event.fromJson(event);
          eventObj.setCoordinates(location);
          return eventObj;
        }).toList();
      } else {
        throw Exception('Falha ao carregar eventos');
      }
    } catch (e) {
      throw Exception('Erro ao buscar eventos: $e');
    }
  }

  Future<Location> getLocation(String location) async {
    final url = '$_baseUrl/locations.json';
    location = location.replaceAll(' ', '+');
    final params = {
      'location': location,
      'api_key': _apiKey,
    };

    try {
      final response = await dio.get(url, queryParameters: params);

      if (response.statusCode == 200) {
        final data = response.data as List;
        final locations = data.map((location) => Location.fromJson(location)).toList();
        return locations[0];
      } else {
        throw Exception('Falha ao carregar localização');
      }
    } catch (e) {
      throw Exception('Erro ao buscar localização: $e');
    }
  }

  Future<List<Location>> getLocationList(String location) async {
    final url = '$_baseUrl/locations.json';
    location = location.replaceAll(' ', '+');
    final params = {
      'location': location,
      'api_key': _apiKey,
    };

    try {
      final response = await dio.get(url, queryParameters: params);

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((location) => Location.fromJson(location)).toList();
      } else {
        throw Exception('Falha ao carregar localização');
      }
    } catch (e) {
      throw Exception('Erro ao buscar localização: $e');
    }
  }

  Future<List<Location>> getLocationListByJson() async {
    try {
      String jsonString = await rootBundle.loadString('lib/assets/locations.json');

      List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((item) => Location.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error loading locations: $e");
    }
  }
}
