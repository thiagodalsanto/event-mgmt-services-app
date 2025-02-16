import 'package:calendar_mgmt_services_app/core/models/iso_division.dart';

class IsoCountry {
  final String code;
  final String name;
  final List<IsoDivision> divisions;

  IsoCountry({
    required this.code,
    required this.name,
    required this.divisions,
  });


  factory IsoCountry.fromJson(String code, Map<String, dynamic> json) {
    return IsoCountry(
      code: code,
      name: json['name'] as String,
      divisions: (json['divisions'] as Map<String, dynamic>)
          .entries
          .map((entry) => IsoDivision(code: entry.key, name: entry.value))
          .toList(),
    );
  }
}