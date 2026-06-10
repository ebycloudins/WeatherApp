import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/data/models/weather_models.dart';

import '../../../../core/constants/api_constants.dart';

class WeatherRemoteDataSource {

  Future<WeatherModel> getWeather(
      String city) async {

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}?key=${ApiConstants.apiKey}&q=$city',
      ),
    );

     final data = jsonDecode(response.body);

  if (data.containsKey('error')) {
    throw Exception(
      data['error']['message'],
    );
  }

  if (response.statusCode != 200) {
    throw Exception("Server error");
  }

  return WeatherModel.fromJson(data);


  }
}