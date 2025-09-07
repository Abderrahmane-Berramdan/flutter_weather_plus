import 'package:flutter/material.dart';
import 'package:flutter_weather_plus/models/weather_model.dart';
import 'package:flutter_weather_plus/provider/theme_provider.dart';
import 'package:flutter_weather_plus/services/weather_service.dart';
import 'package:flutter_weather_plus/widgets/details_column.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? weatherModel;
  bool isLoading = false;

  fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    var response = await WeatherService.getHourlyForecast();
    setState(() {
      weatherModel = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 5, top: 5),
            child: SizedBox(
              width: 300,
              height: 50,
              child: SearchBar(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                hintText: "Search City",
                hintStyle: WidgetStateProperty.all(
                  TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return GestureDetector(
                  onTap: themeProvider.toggleTheme,
                  child: Icon(
                    themeProvider.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Visibility(
            visible: isLoading,
            replacement: weatherModel != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${weatherModel!.location.name}, ${weatherModel!.location.country}",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 30,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Text(
                        "${weatherModel!.current.temp} °C",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weatherModel!.current.condition.text,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 17,
                        ),
                      ),

                      SizedBox(height: 7),
                      SizedBox(
                        height: 180,
                        width: 180,
                        child: Image.network(
                          "https:${weatherModel!.current.condition.image}",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onPrimary,
                              blurRadius: 15,
                              spreadRadius: -15,
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20),
                          ),
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DetailsColumn(
                                  name: "Humidity",
                                  value: weatherModel!.current.humidity
                                      .toDouble(),
                                  unity: "%",
                                  image: "assets/humidity.png",
                                ),
                                DetailsColumn(
                                  name: "Wind",
                                  value: weatherModel!.current.wind,
                                  unity: "Km/h",
                                  image: "assets/windmill.png",
                                ),
                                DetailsColumn(
                                  name: "Max temp",
                                  value: weatherModel!
                                      .forecast
                                      .forecastday[0]
                                      .day
                                      .maxtemp,
                                  unity: "°C",
                                  image: "assets/thermometer.png",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today Forecast",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                                letterSpacing: 1,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Weekly Forecast",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.secondary),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              weatherModel!.forecast.forecastday[0].hour.length,
                          itemBuilder: (context, index) {
                            Hour hour = weatherModel!
                                .forecast
                                .forecastday[0]
                                .hour[index];
                            String formattedTime = DateFormat(
                              "hh:mm a",
                            ).format(DateTime.parse(hour.time));
                            return Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedTime,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.network(
                                      "https:${hour.condition.image}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    "${hour.temp} °C",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Text(
                    "No data Found",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 35,
                    ),
                  ),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
