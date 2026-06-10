import 'package:weather_app/features/weather/data/models/weather_result.dart';

import '../../domain/repositories/weather_repository.dart';
import '../datasource/weather_remote_datasource.dart';
import '../datasource/weather_local_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remote;
  final WeatherLocalDataSource local;

  WeatherRepositoryImpl({required this.remote, required this.local});

  @override
  Future<WeatherResult> getWeather(String city) async {
    try {
      final weather = await remote.getWeather(city);

      await local.cacheWeather(weather);

      return WeatherResult(weather: weather, isFromCache: false);
    } catch (e) {
      final cached = local.getLastWeather();

      if (cached != null) {
        return WeatherResult(
          weather: cached,
          isFromCache: true,
          errorMessage: e.toString(),
        );
      }

      throw Exception(e.toString());
    }
  }
}
