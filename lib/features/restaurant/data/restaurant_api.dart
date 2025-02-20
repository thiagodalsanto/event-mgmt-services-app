import 'package:event_mgmt_services_app/features/restaurant/models/restaurant.dart';
import 'package:dio/dio.dart';

class RestaurantApi {
  static const String _baseUrl = 'https://api.yelp.com/v3/businesses/search';

  static const String _apiKey =
      'XEoVom634jRjOHS6OuVoq59sGY4PGMFyHcjdly7KK6tKsBmX2eTQgFkM_2_yBJfoka81Sjv4NdauDdvGdKzomJVSU90zeRV0B8p0hw73paljJ4kY8ncogehY0uqwZ3Yx';

  final Dio dio = Dio();

  RestaurantApi() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers['Authorization'] = 'Bearer $_apiKey';
  }

  Future<List<Restaurant>> getRestaurantsByLocation(double latitude, double longitude) async {
    final params = {
      'latitude': latitude,
      'longitude': longitude,
      'sort_by': 'best_match',
      'device_plataform': 'mobile_generic',
      'limit': 20,
    };

    try {
      final response = await dio.get(_baseUrl, queryParameters: params);

      if (response.statusCode == 200) {
        final data = response.data['businesses'] as List;
        return Future.wait(data.map((restaurant) => Restaurant.fromJson(restaurant)));
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Failed to load restaurants: $e');
    }
  }
}
