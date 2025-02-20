import 'package:event_mgmt_services_app/core/models/iso_country.dart';
import 'package:event_mgmt_services_app/core/models/iso_division.dart';
import 'package:event_mgmt_services_app/core/services/iso_country_service.dart';
import 'package:flutter/foundation.dart';

class RestaurantLocation {
  final String address;
  final String zipCode;
  final String country;
  final String state;
  final String city;
  late double latitude;
  late double longitude;

  RestaurantLocation({
    required this.address,
    required this.zipCode,
    required this.country,
    required this.state,
    required this.city,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  setCoordinates(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  static Future<RestaurantLocation> fromJson(Map<String, dynamic> json) async {
    try {
      List<IsoCountry> countries = await IsoCountryService().getCountriesByIso();
      IsoCountry country = countries.firstWhere((c) => c.code == json['country']);
      IsoDivision division = country.divisions.firstWhere((d) => d.code == json['state']);

      String address;
      if (json["address1"] != null && json["address1"] != "") {
        address = json["address1"];
      } else if (json["address2"] != null && json["address2"] != "") {
        address = json["address2"];
      } else if (json["address3"] != null && json["address3"] != "") {
        address = json["address3"];
      } else {
        address = json["display_addresses"][0];
      }

      return RestaurantLocation(
        address: address,
        zipCode: json['zip_code'] as String,
        country: country.name,
        state: division.name,
        city: json['city'] as String,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing RestaurantLocation: $e');
      }
      rethrow;
    }
  }

  @override
  String toString() {
    return 'RestaurantLocation{\n'
        '  address: $address,\n'
        '  zipCode: $zipCode,\n'
        '  country: $country,\n'
        '  state: $state,\n'
        '  city: $city,\n'
        '  latitude: $latitude,\n'
        '  longitude: $longitude\n'
        '}';
  }
}
