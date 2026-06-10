import 'package:hive/hive.dart';
import 'package:weather_app/features/weather/data/models/weather_models.dart';

class WeatherLocalDataSource {
  final Box box;

  WeatherLocalDataSource(this.box);

  Future<void> cacheWeather(WeatherModel model) async {
    await box.put('last_weather', model.toJson());
  }

  WeatherModel? getLastWeather() {
    final json = box.get('last_weather');

    if (json == null) return null;

    return WeatherModel.fromCache(
      Map<String, dynamic>.from(json),
    );
  }

  Future<void> saveRecentSearches(
  List<String> searches,
) async {
  await box.put(
    'recent_searches',
    searches,
  );
}

List<String> getRecentSearches() {

  final searches =
      box.get('recent_searches');

  if (searches == null) {
    return [];
  }

  return List<String>.from(searches);
}
}