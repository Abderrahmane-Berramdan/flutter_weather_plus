import 'package:flutter/material.dart';
import 'package:flutter_weather_plus/models/weather_model.dart';
import 'package:flutter_weather_plus/provider/theme_provider.dart';
import 'package:flutter_weather_plus/services/weather_service.dart';
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
    var response = await WeatherService.fechWeather();
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
                      Text(
                        "${weatherModel!.location.name}, ${weatherModel!.location.country}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 35,
                          letterSpacing: 1,
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
                      Image.network(
                        weatherModel!.current.condition.image,
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 100,
                        child: Card(child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            children: [
                              Icon(Icons.water_drop),
                              Text("${weatherModel!.current.humidity} %"),
                              Text("Humidity")
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.wind_power),
                              Text("${weatherModel!.current.wind} Km/h"),
                              Text("Wind")
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.water_drop),
                              Text("${weatherModel!.current.humidity} %"),
                              Text("Max temp")
                            ],
                          )
                        ])),
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
