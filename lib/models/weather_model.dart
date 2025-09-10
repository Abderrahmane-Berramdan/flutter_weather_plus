class WeatherModel {
  final Location location;
  final Current? current;
  final Forecast forecast;
  WeatherModel({this.current, required this.location, required this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: json["current"] != null
          ? Current.fromJson(json["current"])
          : null,
      location: Location.fromJson(json["location"]),
      forecast: Forecast.fromJson(json["forecast"]),
    );
  }
}

class Location {
  final String name;
  final String country;

  Location({required this.name, required this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json["name"], country: json["country"]);
  }
}

class Current {
  final double temp;
  final Condition condition;
  final double wind;
  final int humidity;

  Current({
    required this.temp,
    required this.condition,
    required this.humidity,
    required this.wind,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      temp: json["temp_c"],
      condition: Condition.fromJson(json["condition"]),
      humidity: json["humidity"],
      wind: json["wind_kph"],
    );
  }
}

class Condition {
  final String text;
  final String image;

  Condition({required this.text, required this.image});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(text: json["text"], image: json["icon"]);
  }
}

class Forecast {
  final List<Forecastday> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json["forecastday"] as List)
          .map((day) => Forecastday.fromJson(day))
          .toList(),
    );
  }
}

class Forecastday {
  final String date;
  final Day day;
  final List<Hour> hour;

  Forecastday({required this.day, required this.hour, required this.date});

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      date: json["date"],
      day: Day.fromJson(json["day"]),
      hour: (json["hour"] as List).map((hour) => Hour.fromJson(hour)).toList(),
    );
  }
}

class Day {
  final double maxtemp;
  final double mintemp;
  final Condition condition;

  Day({required this.maxtemp, required this.mintemp, required this.condition});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtemp: json["maxtemp_c"],
      mintemp: json["mintemp_c"],
      condition: Condition.fromJson(json["condition"]),
    );
  }
}

class Hour {
  final double temp;
  final Condition condition;
  final String time;

  Hour({required this.temp, required this.condition, required this.time});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      temp: json["temp_c"],
      condition: Condition.fromJson(json["condition"]),
      time: json["time"],
    );
  }
}