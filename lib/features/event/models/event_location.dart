class Location {
  final String id;
  final String name;
  final String canonicalName;
  final String countryCode;
  final String targetType;
  final int reach;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.name,
    required this.canonicalName,
    required this.countryCode,
    required this.targetType,
    required this.reach,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    List<dynamic>? gpsData = json['gps'];
    return Location(
      id: json['id'],
      name: json['name'],
      canonicalName: json['canonical_name'],
      countryCode: json['country_code'],
      targetType: json['target_type'],
      reach: json['reach'],
      latitude: gpsData != null ? (gpsData[1] as num).toDouble() : 0.0, 
      longitude: gpsData != null ? (gpsData[0] as num).toDouble() : 0.0,
    );
  }

  @override
  String toString() {
    return 'Location{\n'
        '  id: $id,\n'
        '  name: $name,\n'
        '  canonicalName: $canonicalName,\n'
        '  countryCode: $countryCode,\n'
        '  latitude: $latitude,\n'
        '  longitude: $longitude\n'
        '}';
  }
}
