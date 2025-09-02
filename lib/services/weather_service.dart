import 'dart:convert';

import 'package:flutter_weather_plus/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<WeatherModel?> fechWeather() async {
    final String url =
        "https://api.weatherapi.com/v1/current.json?key=407b8f67cd1d4ad5884103610250109&q=Guelma";

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception("Field to load weather data");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
