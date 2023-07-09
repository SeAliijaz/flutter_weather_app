import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';
import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_list_tile.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_mini_card.dart';
import 'package:flutter_weather_app/Custom_Widgets/custom_spinkit.dart';
import 'package:flutter_weather_app/Models/weather_data_model.dart';
import 'package:http/http.dart' as http;

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

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body.toString());
      debugPrint(response.body.toString());
      return WeatherDataModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load weather data'),
                  );
                } else {
                  WeatherDataModel? weatherData = snapshot.data;
                  if (weatherData != null) {
                    return ListView(
                      padding: EdgeInsets.all(10.0),
                      children: [
                        Card(
                          child: ListTile(
                            title: Text("Location & Conditions"),
                          ),
                        ),

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
                                colors: [
                                  Color(0xFF2196F3),
                                  Colors.white,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            height: size.height * 0.25,
                            width: size.width,

                            ///Inside of Weather Container
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomListTile(
                                    leadingIcon: Icons.watch_later_outlined,
                                    title:
                                        "Local Time: ${weatherData.location!.localtime}",
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.location_city_outlined,
                                    title: "${weatherData.location!.name}",
                                    trailingText:
                                        "Temp: ${weatherData.current!.feelslikeC}°C",
                                    isTrailingNeeded: true,
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.location_on_outlined,
                                    title:
                                        "Region: ${weatherData.location!.region}",
                                    trailingText:
                                        "Country: ${weatherData.location!.country}",
                                    isTrailingNeeded: true,
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
                                  ),

                                  ///this is simple listtile just because of traling image.network()
                                  ListTile(
                                    leading: const Icon(Icons.cloud_outlined),
                                    title: Text(
                                        'Condition: ${weatherData.current!.condition!.text}'),
                                    trailing: Image.network(
                                        'http:${weatherData.current!.condition!.icon}'),
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
                    return Center(
                      child: Text('No weather data available'),
                    );
                  }
                }
              },
            )
          : Center(
              child: SpinKitWidget(
                size: 50.0,
                color: Colors.blue[300],
                type: "wave",
              ),
            ),
    );
  }
}
