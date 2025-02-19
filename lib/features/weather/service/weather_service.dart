import 'package:calendar_mgmt_services_app/features/weather/data/weather_api.dart';
import 'package:calendar_mgmt_services_app/features/weather/models/weather.dart';

class WeatherService {
  late WeatherApi _weatherApi;

  WeatherService() {
    _weatherApi = WeatherApi();
  }

  Future<Weather> getWeather(double latitude, double longitude) {
    return _weatherApi.getWeather(latitude, longitude);
  }
}