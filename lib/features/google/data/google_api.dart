import 'package:calendar_mgmt_services_app/features/google/data/google_maps.dart';
import 'package:dio/dio.dart';

class GoogleApi {
  static const String baseUrl = 'https://maps.googleapis.com/maps/api';
  static const String apiKey = 'AIzaSyCDzifH8NTSPps6YGgNTAEDjFl-jTZ5JEU';

  final Dio dio = Dio();

  GoogleApi() {
    dio.options.baseUrl = baseUrl;
  }

  Future<GoogleMaps> getLocationByCoordinates(final double latitude, final double longitude) async {
    final params = {
      'latlng': '$latitude,$longitude',
      'key': apiKey,
    };

    try {
      final response = await dio.get('/geocode/json', queryParameters: params);

      if (response.statusCode == 200) {
        return GoogleMaps.fromJson(response.data);
      } else {
        throw Exception('Falha ao carregar cidade');
      }
    } catch (e) {
      throw Exception('Erro ao buscar cidade: $e');
    }
  }
}
