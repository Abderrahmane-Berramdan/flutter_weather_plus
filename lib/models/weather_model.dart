class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;
  WeatherModel({
    required this.current,
    required this.location,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: Current.fromJson(json["current"]),
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
  final Day day;
  final List<Hour> hour;

  Forecastday({required this.day, required this.hour});

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      day: Day.fromJson(json["day"]),
      hour: (json["hour"] as List).map((hour) => Hour.fromJson(hour)).toList(),
    );
  }
}

class Day {
  final double maxtemp;

  Day({required this.maxtemp});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(maxtemp: json["maxtemp_c"]);
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
    },
  "forecast": {
        "forecastday": [
            {
                "date": "2025-09-04",
                "date_epoch": 1756944000,
                "day": {  /////////////////////////////
                    "maxtemp_c": 34.8, ///////
                    "maxtemp_f": 94.7,
                    "mintemp_c": 21.9,
                    "mintemp_f": 71.4,
                    "avgtemp_c": 27.5,
                    "avgtemp_f": 81.4,
                    "maxwind_mph": 14.1,
                    "maxwind_kph": 22.7,
                    "totalprecip_mm": 0.0,
                    "totalprecip_in": 0.0,
                    "totalsnow_cm": 0.0,
                    "avgvis_km": 10.0,
                    "avgvis_miles": 6.0,
                    "avghumidity": 45,
                    "daily_will_it_rain": 0,
                    "daily_chance_of_rain": 0,
                    "daily_will_it_snow": 0,
                    "daily_chance_of_snow": 0,
                    "condition": {  /////////////
                        "text": "Sunny",
                        "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",  ///////
                        "code": 1000
                    },
                    "uv": 1.9
                },
                "astro": {
                    "sunrise": "06:04 AM",
                    "sunset": "06:54 PM",
                    "moonrise": "05:14 PM",
                    "moonset": "02:04 AM",
                    "moon_phase": "Waxing Gibbous",
                    "moon_illumination": 84,
                    "is_moon_up": 1,
                    "is_sun_up": 0
                },
                "hour": [  //////////////////////////
                    {
                        "time_epoch": 1756940400,
                        "time": "2025-09-04 00:00",
                        "temp_c": 21.9,  /////////////
                        "temp_f": 71.4,
                        "is_day": 0,
                        "condition": {
                            "text": "Clear ",
                            "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                            "code": 1000
                        },
                        "wind_mph": 1.6,
                        "wind_kph": 2.5,
                        "wind_degree": 107,
                        "wind_dir": "ESE",
                        "pressure_mb": 1016.0,
                        "pressure_in": 30.01,
                        "precip_mm": 0.0,
                        "precip_in": 0.0,
                        "snow_cm": 0.0,
                        "humidity": 59,
                        "cloud": 3,
                        "feelslike_c": 21.9,
                        "feelslike_f": 71.4,
                        "windchill_c": 21.9,
                        "windchill_f": 71.4,
                        "heatindex_c": 24.5,
                        "heatindex_f": 76.2,
                        "dewpoint_c": 13.4,
                        "dewpoint_f": 56.2,
                        "will_it_rain": 0,
                        "chance_of_rain": 0,
                        "will_it_snow": 0,
                        "chance_of_snow": 0,
                        "vis_km": 10.0,
                        "vis_miles": 6.0,
                        "gust_mph": 2.8,
                        "gust_kph": 4.4,
                        "uv": 0,
                        "short_rad": 0,
                        "diff_rad": 0,
                        "dni": 0,
                        "gti": 0
                    },
                  ]
                }
              ]
            }
}
 */