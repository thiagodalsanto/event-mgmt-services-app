import 'package:event_mgmt_services_app/features/restaurant/models/business_hours.dart';
import 'package:event_mgmt_services_app/features/restaurant/models/restaurant_location.dart';
import 'package:flutter/foundation.dart';

class Restaurant {
  final String name;
  final RestaurantLocation location;
  final bool isPermanentlyClosed;
  final List<String> categories;
  final String url;
  final String phone;
  final double distance;
  final String menuUrl;
  List<BusinessHours>? hours;

  Restaurant({
    required this.name,
    required this.location,
    required this.isPermanentlyClosed,
    required this.categories,
    required this.url,
    required this.phone,
    required this.distance,
    required this.hours,
    required this.menuUrl,
  });

  static Future<Restaurant> fromJson(Map<String, dynamic> json) async {
    // Handle location first since it's an async operation
    try {
      RestaurantLocation location = await RestaurantLocation.fromJson(json['location']);

      // Set coordinates if available
      if (json['coordinates'] != null) {
        location.setCoordinates(
            json['coordinates']['latitude'] as double, json['coordinates']['longitude'] as double);
      }

      // Extract categories titles into a list
      List<String> categories =
          (json['categories'] as List).map((category) => category['title'] as String).toList();

      // Get the first business hours entry and its first open slot
      // Assuming the first entry is the regular hours
      List<dynamic> businessHours = [];
      List<BusinessHours> hours = [];
      if (json['business_hours'] != null && json['business_hours'].length > 0) {
        businessHours = json['business_hours'][0]['open'];
        hours = businessHours.map((hour) => BusinessHours.fromJson(hour)).toList();
      }

      return Restaurant(
        name: json['name'] as String,
        location: location,
        isPermanentlyClosed: json['is_closed'] as bool,
        categories: categories,
        url: json['url'] as String,
        phone: json['display_phone'] as String,
        distance: json['distance'] as double,
        hours: hours,
        menuUrl: json['attributes']?['menu_url'] as String? ?? '',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing Restaurant: $e');
      }
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Restaurant(name: $name, '
        'location: ${location.toString()}, '
        'isPermanentlyClosed: $isPermanentlyClosed, '
        'categories: $categories, '
        'url: $url, '
        'phone: $phone, '
        'distance: $distance, '
        'hours: ${hours?.map((hour) => hour.toString()).join(', ')}, '
        'menuUrl: $menuUrl)';
  }
}
