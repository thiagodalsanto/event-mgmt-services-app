class Location {
  final String id;
  final int googleId;
  final int googleParentId;
  final String name;
  final String canonicalName;
  final String countryCode;
  final String targetType;
  final int reach;
  final double? latitude;
  final double? longitude;

  Location({
    required this.id,
    required this.googleId,
    required this.googleParentId,
    required this.name,
    required this.canonicalName,
    required this.countryCode,
    required this.targetType,
    required this.reach,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    List<dynamic>? gpsData = json['gps']; // Some entries don't have 'gps'
    return Location(
      id: json['id'],
      googleId: json['google_id'],
      googleParentId: json['google_parent_id'],
      name: json['name'],
      canonicalName: json['canonical_name'],
      countryCode: json['country_code'],
      targetType: json['target_type'],
      reach: json['reach'],
      latitude: gpsData != null ? gpsData[1] : null, // Latitude is second
      longitude: gpsData != null ? gpsData[0] : null, // Longitude is first
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'google_id': googleId,
      'google_parent_id': googleParentId,
      'name': name,
      'canonical_name': canonicalName,
      'country_code': countryCode,
      'target_type': targetType,
      'reach': reach,
      if (latitude != null && longitude != null) 'gps': [longitude, latitude], // Keeping original JSON format
    };
  }
}
