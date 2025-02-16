import 'package:calendar_mgmt_services_app/features/weather/models/weather.dart';
import 'package:dio/dio.dart';

class WeatherApi {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '335b65b6783d6d8899599a14fe41b76c';

  final Dio dio = Dio();

  WeatherApi(){
    dio.options.baseUrl = _baseUrl;
  }

  Future<Weather> getWeather(double latitude, double longitude){
    final params = {
      'lat': latitude,
      'lon': longitude,
      'appid': _apiKey,
      'units': 'metric',
    };

    return dio.get('', queryParameters: params).then((response){
      if(response.statusCode == 200){
        return Weather.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather');
      }
    });
  }
}
