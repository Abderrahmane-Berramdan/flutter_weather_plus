import 'package:flutter/material.dart';
import 'package:flutter_weather_plus/models/weather_model.dart';
import 'package:flutter_weather_plus/services/weather_service.dart';
import 'package:flutter_weather_plus/widgets/forcast_list.dart';

enum WeatherState { loading, loaded, error }

class WeeklyForecastScreen extends StatefulWidget {
  final WeatherModel? weatherModel;
  final String city;
  const WeeklyForecastScreen({
    super.key,
    required this.weatherModel,
    required this.city,
  });

  @override
  State<WeeklyForecastScreen> createState() => _WeeklyForecastScreenState();
}

class _WeeklyForecastScreenState extends State<WeeklyForecastScreen> {
  WeatherModel? previousWeather;
  WeatherState state = WeatherState.loading;
  Future<void> fetchPreviousWeather() async {
    setState(() {
      state = WeatherState.loading;
    });
    final response = await WeatherService.getLast7DaysWeather(widget.city);
    setState(() {
      previousWeather = response;
      state = response == null ? WeatherState.error : WeatherState.loaded;
    });
  }

  @override
  void initState() {
    fetchPreviousWeather();
    super.initState();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget buildError(String message) {
    return Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 22,
      ),
    );
  }

  Widget buildCurrentWeather(WeatherModel weatherModel) {
    return Column(
      children: [
        Text(
          "${weatherModel.location.name}, ${weatherModel.location.country}",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 27,
            letterSpacing: 1,
          ),
        ),
        Text(
          "${weatherModel.current!.temp} °C",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weatherModel.current!.condition.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 180,
          width: 180,
          child: Image.network(
            "https:${weatherModel.current!.condition.image}",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Builder(
              builder: (context) {
                if (state == WeatherState.loading) {
                  return buildLoading();
                } else if (widget.weatherModel == null) {
                  return buildError("No Data Found (Current Weather)");
                } else if (state == WeatherState.error ||
                    previousWeather == null) {
                  return buildError("No Data Found (Previous Weather)");
                }
                return ListView(
                  children: [
                    buildCurrentWeather(widget.weatherModel!),
                    SizedBox(height: 15),
                    Text(
                      "Next 7 Days Forecast",
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),
                    ForecastList(model: widget.weatherModel!),
                    SizedBox(height: 10),

                    Text(
                      "Previous 7 Days Forecast",
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ForecastList(model: previousWeather!),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
