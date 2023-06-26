import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///Title of App
      title: 'Weather App',

      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///theme: ThemeData()
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textTheme: GoogleFonts.albertSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      ///home: [Initial Route]
      home: HomeScreen(),
    );
  }
}
