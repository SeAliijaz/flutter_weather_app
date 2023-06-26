import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';
import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
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
    final String apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=${ApiConstants.apiKey}&q=$location&aqi=no';
    var response = await http.get(Uri.parse(apiUrl));

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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to load weather data'),
                  );
                } else {
                  ///value assigned to snapshot.data
                  WeatherDataModel? weatherData = snapshot.data;
                  if (weatherData != null) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                  'Location: ${weatherData.location!.name}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_city),
                              title: Text(
                                  'Region: ${weatherData.location!.region}'),
                            ),

                            ///Condition
                            ListTile(
                              leading: const Icon(Icons.cloud),
                              title: Text(
                                  'Condition: ${weatherData.current!.condition!.text}'),
                              trailing: Image.network(
                                  'http:${weatherData.current!.condition!.icon}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.public),
                              title: Text(
                                  'Country: ${weatherData.location!.country}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                  'Latitude: ${weatherData.location!.lat}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                  'Longitude: ${weatherData.location!.lon}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(
                                  'Local Time: ${weatherData.location!.localtime}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Temperature (Celsius): ${weatherData.current!.tempC}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Temperature (Fahrenheit): ${weatherData.current!.tempF}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.wb_sunny),
                              title:
                                  Text('Is Day: ${weatherData.current!.isDay}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.waves),
                              title: Text(
                                  'Wind Speed (MPH): ${weatherData.current!.windMph}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.waves),
                              title: Text(
                                  'Wind Speed (KPH): ${weatherData.current!.windKph}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.navigation),
                              title: Text(
                                  'Wind Direction: ${weatherData.current!.windDir}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.barcode_reader),
                              title: Text(
                                  'Pressure (mb): ${weatherData.current!.pressureMb}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.barcode_reader),
                              title: Text(
                                  'Pressure (in): ${weatherData.current!.pressureIn}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.umbrella),
                              title: Text(
                                  'Precipitation (mm): ${weatherData.current!.precipMm}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.umbrella),
                              title: Text(
                                  'Precipitation (in): ${weatherData.current!.precipIn}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.opacity),
                              title: Text(
                                  'Humidity: ${weatherData.current!.humidity}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.cloud),
                              title:
                                  Text('Cloud: ${weatherData.current!.cloud}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Feels Like (Celsius): ${weatherData.current!.feelslikeC}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Feels Like (Fahrenheit): ${weatherData.current!.feelslikeF}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.visibility),
                              title: Text(
                                  'Visibility (km): ${weatherData.current!.visKm}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.visibility),
                              title: Text(
                                  'Visibility (miles): ${weatherData.current!.visMiles}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.wb_sunny),
                              title:
                                  Text('UV Index: ${weatherData.current!.uv}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.waves),
                              title: Text(
                                  'Gust Speed (MPH): ${weatherData.current!.gustMph}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.waves),
                              title: Text(
                                  'Gust Speed (KPH): ${weatherData.current!.gustKph}'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No weather data available'),
                    );
                  }
                }
              },
            )
          : Container(),
    );
  }
}
