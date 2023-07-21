import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';
import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_list_tile.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_mini_card.dart';
import 'package:flutter_weather_app/Models/weather_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<WeatherDataModel>? _weatherDataFuture;

  Future<WeatherDataModel> fetchData(String location) async {
    final String uri =
        'http://api.weatherapi.com/v1/current.json?key=${ApiConstants.apiKey}&q=$location&aqi=no';

    var response = await http.get(Uri.parse(uri));

    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body.toString());
        debugPrint(response.body.toString());
        return WeatherDataModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      return AppConstants.showToast(e.toString());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    // Update time every minute
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        flexibleSpace: const AppBarGradient(),
        leading: IconButton(
            onPressed: () {
              AppConstants.showToast("Will Add This Soon :)");
            },
            icon: Icon(Icons.menu_outlined)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: 'Search location',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: () {
                    String location = _searchController.text;
                    setState(() {
                      _weatherDataFuture = fetchData(location);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: _weatherDataFuture != null
          ? FutureBuilder<WeatherDataModel>(
              future: _weatherDataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherDataModel> snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return AppConstants.progressIndicator(
                        "Failed To Load Data.", "doubleBounce");
                  } else {
                    WeatherDataModel? weatherData = snapshot.data;
                    if (weatherData != null) {
                      return ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          ///Weather Container
                          Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: size.height * 0.35,
                              width: size.width,

                              ///Inside of Weather Container
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomListTile(
                                      leadingIcon: Icons.watch_later_outlined,

                                      ///current time format
                                      ///it will change after every minute
                                      title:
                                          "Current Time: ${DateFormat('h:mm a').format(_currentTime)}",

                                      ///------------------------------------------------
                                      //     "Local Time: ${DateFormat('h:mm a').format(
                                      //   DateTime.parse(
                                      //     weatherData.location!.localtime
                                      //         .toString(),
                                      //   ),
                                      // )}",
                                      ///------------------------------------------------
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.location_city_outlined,
                                      title: "${weatherData.location!.name}",
                                      subtitle:
                                          "Temp: ${weatherData.current!.feelslikeC}°C",
                                      isSubtitleNeeded: true,
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.location_on_outlined,
                                      title: "${weatherData.location!.region}",
                                      trailingText:
                                          "${weatherData.location!.country}",
                                      subtitle: "${weatherData.location!.tzId}",
                                      isSubtitleNeeded: true,
                                      isTrailingNeeded: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///2nd Card
                          Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: size.height * 0.60,
                              width: size.width,

                              ///Inside of Weather Container
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomListTile(
                                      leadingIcon: Icons.wb_sunny_outlined,
                                      title:
                                          "Is Day: ${weatherData.current!.isDay}",
                                    ),

                                    ///this is simple listtile just because of traling image.network()
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: ListTile(
                                          leading: const Icon(
                                              Icons.cloud_outlined,
                                              color: Colors.black),
                                          title: Text(
                                            'Condition: ${weatherData.current!.condition!.text}',
                                          ),
                                          trailing: Image.network(
                                              'http:${weatherData.current!.condition!.icon}'),
                                        ),
                                      ),
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.thermostat_outlined,
                                      title:
                                          "Feels Like: ${weatherData.current!.feelslikeC}°C",
                                    ),

                                    CustomListTile(
                                      leadingIcon: Icons.thermostat_outlined,
                                      title:
                                          "Feels Like: ${weatherData.current!.feelslikeF}°F",
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.opacity_outlined,
                                      title:
                                          'Humidity: ${weatherData.current!.humidity}%',
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.cloud_circle_outlined,
                                      title:
                                          'Cloud: ${weatherData.current!.cloud}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///Mini Cards Scrollable Row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomMiniCard(
                                  iconData: Icons.wind_power_outlined,
                                  title:
                                      "Wind Speed: ${weatherData.current!.windMph}mp/h",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.wind_power_outlined,
                                  title:
                                      "Wind Speed: ${weatherData.current!.windKph}km/h",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.waves_outlined,
                                  title:
                                      "Wind Degree: ${weatherData.current!.windDegree}",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.barcode_reader,
                                  title:
                                      "Pressure: ${weatherData.current!.pressureMb} mb",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.barcode_reader,
                                  title:
                                      "Pressure: ${weatherData.current!.pressureIn} In",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.visibility_outlined,
                                  title:
                                      "Visibility: ${weatherData.current!.visKm} km",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.visibility_outlined,
                                  title:
                                      "Visibility: ${weatherData.current!.visMiles} mm",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.wb_sunny_outlined,
                                  title: "UV Index: ${weatherData.current!.uv}",
                                ),
                              ],
                            ),
                          ),

                          ///Data in Column
                          CustomMiniCard(
                            iconData: Icons.umbrella_outlined,
                            title:
                                "Precipitation: ${weatherData.current!.precipMm} mm",
                          ),
                          CustomMiniCard(
                            iconData: Icons.umbrella_outlined,
                            title:
                                "Precipitation: ${weatherData.current!.precipIn} in",
                          ),

                          ///Data in Row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomMiniCard(
                                  iconData: Icons.wind_power_outlined,
                                  title:
                                      "Wind Dir: ${weatherData.current!.windDir}",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.wind_power_outlined,
                                  title:
                                      "Gust Mph: ${weatherData.current!.gustMph}",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.wind_power_outlined,
                                  title:
                                      "Gust Kph: ${weatherData.current!.gustKph}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return AppConstants.progressIndicator(
                          "No Weather Data to Show.", "doubleBounce");
                    }
                  }
                } catch (e) {
                  return AppConstants.showToast(e.toString());
                }
              },
            )
          : Center(
              child: AppConstants.progressIndicator(
                  "No Weather Data Found", "doubleBounce")),
    );
  }
}



/*
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';
import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_list_tile.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_mini_card.dart';
import 'package:flutter_weather_app/Models/weather_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<WeatherDataModel>? _weatherDataFuture;

  Future<WeatherDataModel> fetchData(String location) async {
    final String currentWeatherUri =
        'http://api.weatherapi.com/v1/current.json?key=${ApiConstants.apiKey}&q=$location&aqi=no';
    final String forecastUri =
        'http://api.weatherapi.com/v1/forecast.json?key=${ApiConstants.apiKey}&q=$location&days=7&aqi=no';

    var currentWeatherResponse = await http.get(Uri.parse(currentWeatherUri));
    var forecastResponse = await http.get(Uri.parse(forecastUri));

    try {
      if (currentWeatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        var currentWeatherJson = json.decode(currentWeatherResponse.body.toString());
        var forecastJson = json.decode(forecastResponse.body.toString());

        WeatherDataModel currentWeatherData = WeatherDataModel.fromJson(currentWeatherJson);
        currentWeatherData.forecast = WeatherDataModel.parseForecastData(forecastJson);

        return currentWeatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      return AppConstants.showToast(e.toString());
    }
  }

  // ... (rest of the code remains unchanged)

  @override
  Widget build(BuildContext context) {
    // ... (rest of the code remains unchanged)

    return Scaffold(
      // ... (rest of the code remains unchanged)

      body: _weatherDataFuture != null
          ? FutureBuilder<WeatherDataModel>(
              future: _weatherDataFuture,
              builder: (BuildContext context, AsyncSnapshot<WeatherDataModel> snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return AppConstants.progressIndicator(
                        "Failed To Load Data.", "doubleBounce");
                  } else {
                    WeatherDataModel? weatherData = snapshot.data;
                    if (weatherData != null) {
                      return ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          ///Weather Container
                          Card(
                            // ... (rest of the code remains unchanged)
                          ),

                          ///2nd Card
                          Card(
                            // ... (rest of the code remains unchanged)
                          ),

                          ///Mini Cards Scrollable Row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // ... (rest of the code remains unchanged)
                              ],
                            ),
                          ),

                          ///Data in Column
                          CustomMiniCard(
                            // ... (rest of the code remains unchanged)
                          ),
                          CustomMiniCard(
                            // ... (rest of the code remains unchanged)
                          ),

                          ///Data in Row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // ... (rest of the code remains unchanged)
                              ],
                            ),
                          ),

                          /// Forecast for 7 days
                          SizedBox(height: 20),
                          Text(
                            '7-day Forecast:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: weatherData.forecast!.map((dayForecast) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat('E, d MMM').format(dayForecast.date),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Image.network('http:${dayForecast.day!.condition!.icon}'),
                                      Text('${dayForecast.day!.maxtempC}°C'),
                                      Text('${dayForecast.day!.mintempC}°C'),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return AppConstants.progressIndicator("No Weather Data to Show.", "doubleBounce");
                    }
                  }
                } catch (e) {
                  return AppConstants.showToast(e.toString());
                }
              },
            )
          : Center(
              child: AppConstants.progressIndicator("No Weather Data Found", "doubleBounce")),
    );
  }
}

*/