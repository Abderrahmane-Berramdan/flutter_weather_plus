class WeatherModel {
  final Location location;
  final Current current;
  WeatherModel({required this.current, required this.location});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: Current.fromJson(json["current"]),
      location: Location.fromJson(json["location"]),
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




/*
  {
    "location": {
        "name": "Algiers",    //////////////
        "region": "Alger",
        "country": "Algeria",    //////////////
        "lat": 36.7631,
        "lon": 3.0506,
        "tz_id": "Africa/Algiers",
        "localtime_epoch": 1756805623,
        "localtime": "2025-09-02 10:33"
    },
    "current": {
        "last_updated_epoch": 1756805400,
        "last_updated": "2025-09-02 10:30",
        "temp_c": 25.2,     //////////////
        "temp_f": 77.4,
        "is_day": 1,
        "condition": {
            "text": "Partly cloudy",    //////////////
            "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",    //////////////
            "code": 1003
        },
        "wind_mph": 7.4,
        "wind_kph": 11.9,   //////////////
        "wind_degree": 282,
        "wind_dir": "WNW",
        "pressure_mb": 1018.0,
        "pressure_in": 30.06,
        "precip_mm": 0.0,
        "precip_in": 0.0,
        "humidity": 57,   //////////////
        "cloud": 50,
        "feelslike_c": 26.6,
        "feelslike_f": 79.8,
        "windchill_c": 24.7,
        "windchill_f": 76.5,
        "heatindex_c": 26.1,
        "heatindex_f": 79.0,
        "dewpoint_c": 17.5,
        "dewpoint_f": 63.5,
        "vis_km": 10.0,
        "vis_miles": 6.0,
        "uv": 4.0,
        "gust_mph": 8.9,
        "gust_kph": 14.3,
        "short_rad": 331.94,
        "diff_rad": 123.54,
        "dni": 404.88,
        "gti": 232.47
    }
}
 */