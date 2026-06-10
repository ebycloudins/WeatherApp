import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/glass_card.dart';

Widget weatherCard(provider) {
  final weather = provider.weather;

  if (weather == null) return const SizedBox();

  return GlassCard(
    child: Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          Text(
            weather.city,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "${weather.temperature}°C",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 4),
          Text(
            weather.condition,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 10),
          Image.network(weather.iconUrl.replaceFirst('64x64', '128x128')),

          const SizedBox(height: 10),
          _infoRow(
            "Humidity",
            "${weather.humidity}%",
            icon: const Icon(Icons.water_drop, size: 18),
          ),
          _infoRow(
            "Wind",
            "${weather.windSpeed} km/h",
            icon: const Icon(Icons.air, size: 18),
          ),
        ],
      ),
    ),
  );
}

Widget _infoRow(String label, String value, {Widget? icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),

        Row(
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 8)],

            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
  );
}
