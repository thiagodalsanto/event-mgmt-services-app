class Weather {

  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String condition;
  final String description;  // Detailed weather description
  final double windSpeed;
  final int windDirection;
  final int humidity;
  final int pressure;
  final int cloudiness;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.pressure,
    required this.cloudiness,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json["main"]["temp"].toDouble(),
      feelsLike: json["main"]["feels_like"].toDouble(),
      tempMin: json["main"]["temp_min"].toDouble(),
      tempMax: json["main"]["temp_max"].toDouble(),
      condition: json["weather"][0]["main"],
      description: json["weather"][0]["description"], 
      windSpeed: json["wind"]["speed"].toDouble(),
      windDirection: json["wind"]["deg"],
      humidity: json["main"]["humidity"],
      pressure: json["main"]["pressure"],
      cloudiness: json["clouds"]["all"],
      sunrise: DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunrise"] * 1000, isUtc: true),
      sunset: DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunset"] * 1000, isUtc: true),
    );
  }
  @override
  String toString() {
    return 'Weather{\n'
      '  Temperature: $temperature°C,\n'
      '  Feels Like: $feelsLike°C,\n'
      '  Min Temp: $tempMin°C,\n'
      '  Max Temp: $tempMax°C,\n'
      '  Condition: $condition,\n'
      '  Description: $description,\n'
      '  Wind Speed: $windSpeed m/s,\n'
      '  Wind Direction: $windDirection°,\n'
      '  Humidity: $humidity%,\n'
      '  Pressure: $pressure hPa,\n'
      '  Cloudiness: $cloudiness%,\n'
      '  Sunrise: ${sunrise.toLocal()},\n'
      '  Sunset: ${sunset.toLocal()},\n'
      '}';
  }
}