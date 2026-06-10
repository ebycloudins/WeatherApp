import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.city,
    required super.temperature,
    required super.condition,
    required super.humidity,
    required super.windSpeed,
    required super.code,
    required super.iconUrl
  });

  factory WeatherModel.fromJson(
      Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      temperature:
          json['current']['temp_c'].toDouble(),
      condition:
          json['current']['condition']['text'],
      humidity:
          json['current']['humidity'],
      windSpeed:
          json['current']['wind_kph'].toDouble(),
      code: 
          json['current']['condition']['code'],
      iconUrl:  "https:${json['current']['condition']['icon']}"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'temperature': temperature,
      'condition': condition,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'code': code,
      'iconUrl': iconUrl
    };
  }

  factory WeatherModel.fromCache(
      Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
      code: json['code'],
      iconUrl: json['iconUrl']
    );
  }
}