class GoogleMaps {
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  GoogleMaps({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  String getLocation(){
    return '$city, $state, $country';
  }

  factory GoogleMaps.fromJson(Map<String, dynamic> json) {
    var result = json['results'][0]; // Pega o primeiro resultado

    // Itera pelos componentes do endereço para achar cidade, estado e país
    String? city;
    String? state;
    String? country;
    String? postalCode;

    for (var component in result['address_components']) {
      if (component['types'].contains('locality')) {
        city = component['long_name'];
      }
      if (component['types'].contains('administrative_area_level_1') ||
          component['types'].contains('administrative_area_level_2')) {
        state = component['long_name'];
      }
      if (component['types'].contains('country')) {
        country = component['long_name'];
      }
      if(component['types'].contains('postal_code')){
        postalCode = component['long_name'];
      }
    }

    // Extrai a latitude e longitude
    var location = result['geometry']['location'];
    double lat = location['lat'];
    double lng = location['lng'];

    // Retorna o objeto preenchido
    return GoogleMaps(
      address: result['formatted_address'],
      city: city ?? 'Unknown',
      state: state ?? 'Unknown',
      country: country ?? 'Unknown',
      latitude: lat,
      longitude: lng,
      postalCode: postalCode ?? 'Unknown',
    );
  }
}
