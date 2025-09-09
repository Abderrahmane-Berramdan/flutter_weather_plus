import 'package:flutter/material.dart';
import 'package:flutter_weather_plus/models/weather_model.dart';

class ForecastList extends StatelessWidget {
  final WeatherModel model;
  const ForecastList({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.forecast.forecastday.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            model.forecast.forecastday[index].date,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          subtitle: Text(
            "${model.forecast.forecastday[index].day.condition.text} ${model.forecast.forecastday[index].day.mintemp}°C - ${model.forecast.forecastday[index].day.maxtemp}°C",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          leading: Image.network(
            "https:${model.forecast.forecastday[index].day.condition.image}",
          ),
        );
      },
    );
  }
}
