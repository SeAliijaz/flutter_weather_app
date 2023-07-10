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
        leading: const Icon(Icons.menu_outlined),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  colors: AppConstants.cardColors,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              height: size.height * 0.30,
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

                                      isWhiteColorNeeded: true,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.location_city_outlined,
                                      title: "${weatherData.location!.name}",
                                      trailingText:
                                          "Temp: ${weatherData.current!.feelslikeC}°C",
                                      isTrailingNeeded: true,
                                      isWhiteColorNeeded: true,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.location_on_outlined,
                                      title:
                                          "Region: ${weatherData.location!.region}",
                                      trailingText:
                                          "Country: ${weatherData.location!.country}",
                                      subtitle: "${weatherData.location!.tzId}",
                                      fontWeight: FontWeight.bold,
                                      isSubtitleNeeded: true,
                                      isTrailingNeeded: true,
                                      isWhiteColorNeeded: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///2nd Card
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: size.height * 0.45,
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
                                      fontWeight: FontWeight.bold,
                                    ),

                                    ///this is simple listtile just because of traling image.network()
                                    ListTile(
                                      leading: const Icon(Icons.cloud_outlined,
                                          color: Colors.black),
                                      title: Text(
                                        'Condition: ${weatherData.current!.condition!.text}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Image.network(
                                          'http:${weatherData.current!.condition!.icon}'),
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.thermostat_outlined,
                                      title:
                                          "Feels Like: ${weatherData.current!.feelslikeC}°C",
                                      fontWeight: FontWeight.bold,
                                    ),

                                    CustomListTile(
                                      leadingIcon: Icons.thermostat_outlined,
                                      title:
                                          "Feels Like: ${weatherData.current!.feelslikeF}°F",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomListTile(
                                      leadingIcon: Icons.opacity_outlined,
                                      title:
                                          'Humidity: ${weatherData.current!.humidity}%',
                                      fontWeight: FontWeight.bold,
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
                                  iconData: Icons.waves_outlined,
                                  title:
                                      "Wind Speed: ${weatherData.current!.windKph}km/h",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.barcode_reader,
                                  title:
                                      "Pressure: ${weatherData.current!.pressureMb} mb",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.umbrella,
                                  title:
                                      "Precipitation: ${weatherData.current!.precipMm} mm",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.visibility,
                                  title:
                                      "Visibility: ${weatherData.current!.visKm} km",
                                ),
                                CustomMiniCard(
                                  iconData: Icons.wb_sunny,
                                  title: "UV Index: ${weatherData.current!.uv}",
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
