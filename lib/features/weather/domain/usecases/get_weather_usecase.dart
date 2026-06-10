import 'package:weather_app/features/weather/data/models/weather_result.dart';

import '../repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherResult> call(String city) async {
    return await repository.getWeather(city);
  }
}