import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/data/datasource/weather_local_datasource.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_usecase.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherProvider extends ChangeNotifier {
  final GetWeatherUseCase getWeatherUseCase;
  final WeatherLocalDataSource local;

  WeatherProvider(this.getWeatherUseCase, this.local);

  WeatherEntity? weather;
  bool isLoading = false;
  String? error;
  bool isFromCache = false;
  bool isDarkMode = false;

  String? lastSearchedCity;

  List<String> recentSearches = [];

  final TextEditingController searchController = TextEditingController();

  void loadRecentSearches() {
    recentSearches = local.getRecentSearches();

    notifyListeners();
  }

  Future<void> searchWeather(String city) async {
    isLoading = true;
    error = null;
    lastSearchedCity = city;
    notifyListeners();

    try {
      final result = await getWeatherUseCase(city);

      weather = result.weather;
      isFromCache = result.isFromCache;

      error = result.errorMessage;

      await addRecentSearch(city);
    } catch (e) {
      weather = null;
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshWeather() async {
    if (lastSearchedCity == null) {
      return;
    }

    await searchWeather(lastSearchedCity!);
  }

  Future<void> addRecentSearch(String city) async {
    recentSearches.remove(city);

    recentSearches.insert(0, city);

    if (recentSearches.length > 4) {
      recentSearches.removeLast();
    }

    await local.saveRecentSearches(recentSearches);

    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
