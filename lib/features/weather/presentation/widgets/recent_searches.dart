import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

Widget recentSearches(BuildContext context) {
  final provider = context.watch<WeatherProvider>();

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        const Text(
          "Recent Searches",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: provider.recentSearches.map((city) {
            return Material(
  color: Colors.transparent,
  child: InkWell(
    borderRadius: BorderRadius.circular(20),
    splashColor: Colors.white.withOpacity(0.8),
    highlightColor: Colors.white.withOpacity(0.2),
    onTap: () {
      provider.searchWeather(city);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade700,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        city,
        style: const TextStyle(fontSize: 12),
      ),
    ),
  ),
);
          }).toList(),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}
