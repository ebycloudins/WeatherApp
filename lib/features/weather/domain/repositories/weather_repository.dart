import 'package:weather_app/features/weather/data/models/weather_result.dart';

abstract class WeatherRepository {
  Future<WeatherResult> getWeather(String city);
}