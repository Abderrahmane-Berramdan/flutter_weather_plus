import 'dart:convert';
import 'package:flutter_weather_plus/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<WeatherModel?> getHourlyForecast() async {
    final String url =
        "https://api.weatherapi.com/v1/forecast.json?key=407b8f67cd1d4ad5884103610250109&q=Paris&days=7";

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

  static Future<WeatherModel?> getPastSevenDayWeather() async {
    DateTime currentDate = DateTime.now();
    DateTime endDate = currentDate.subtract(Duration(days: 1));
    DateTime startDate = currentDate.subtract(Duration(days: 7));
    String formattedstartDate =
        "${startDate.year}-${startDate.month.toString().padLeft(2, "0")}-${startDate.day.toString().padLeft(2, "0")}";

    final String url =
        "https://api.weatherapi.com/v1/history.json?key=407b8f67cd1d4ad5884103610250109&q=Guelma&dt=$formattedstartDate&end_dt=$endDate";

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception("Field to load past 7 day weather");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
