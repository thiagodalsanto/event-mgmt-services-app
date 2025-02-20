import 'package:event_mgmt_services_app/features/restaurant/data/restaurant_api.dart';
import 'package:event_mgmt_services_app/features/restaurant/models/restaurant.dart';

class RestaurantService {
  late RestaurantApi _restaurantApi;

  RestaurantService() {
    _restaurantApi = RestaurantApi();
  }

  Future<List<Restaurant>> getRestaurantsByCoordinates(double latitude, double longitude) async {
    final restaurants = await _restaurantApi.getRestaurantsByLocation(latitude, longitude);
    return restaurants;
  }
}
