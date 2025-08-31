import 'package:flutter/material.dart';
import 'package:flutter_weather_plus/provider/theme_provider.dart';
import 'package:flutter_weather_plus/screens/splash_screen.dart';
import 'package:flutter_weather_plus/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: SplashScreen(),
    );
  }
}
