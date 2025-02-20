import 'dart:convert';
import 'package:calendar_mgmt_services_app/core/models/iso_country.dart';
import 'package:flutter/services.dart';

class IsoCountryService {
  Future<List<IsoCountry>> getCountriesByIso() async {
    try {
      String jsonString = await rootBundle.loadString('lib/assets/ISO_3166.json');

      Map<String, dynamic> jsonMap = json.decode(jsonString);

      List<IsoCountry> countries = jsonMap.entries
          .map((entry) => IsoCountry.fromJson(entry.key, entry.value))
          .toList();

      return countries;
    } catch (e) {
      throw Exception("Error loading countries: $e");
    }
  }
}
