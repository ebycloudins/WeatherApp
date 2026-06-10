import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherResult {
  final WeatherEntity weather;
  final bool isFromCache;
  final String? errorMessage;

  WeatherResult({
    required this.weather,
    required this.isFromCache,
    this.errorMessage,
  });
}